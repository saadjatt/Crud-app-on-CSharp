using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.DataVisualization.Charting;

namespace StudentsRecords
{
    public partial class RecordsPage : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(WebConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            // ConnectDb();

            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
                FillChartView();
                FillChartView2();


            }

        }
        public void ConnectDb()
        {
            SqlConnection con = new SqlConnection(
                WebConfigurationManager.ConnectionStrings["mydbcon"].ConnectionString);
            con.Open();
            if (con.State == System.Data.ConnectionState.Open)
            {
                DisplayMsg(this, "SUCCESSFUL");
            }
        }

           static public void DisplayMsg(Control page,string msg) {
                string myScript = String.Format("alert('{0}')",msg);
                ScriptManager.RegisterStartupScript(page, page.GetType(), "MyScript", myScript, true);
            }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
         public void Clear() {

            hfRecordID.Value = "";
            txtName.Text = txtRole.Text = txtScore.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;

        }
        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("RecordsViewAll", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvRecords.DataSource = dtbl;
            gvRecords.DataBind();

        }
        void FillChartView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            

            SqlCommand cmd = new
                   SqlCommand("Select Name,Score from students_records", sqlCon);
            
            SqlDataReader rdr = cmd.ExecuteReader();
            // Retrieve the Series to which we want to add DataPoints
            Series series = Chart1.Series["Series1"];
            // Loop thru each Student record
            while (rdr.Read())
            {
                // Add X and Y values using AddXY() method
                series.Points.AddXY(rdr["name"].ToString(),
                    rdr["score"]);
            }
            rdr.Close();

        }

        void FillChartView2()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();


            SqlCommand cmd = new
                   SqlCommand("Select Name,Score from students_records", sqlCon);

            SqlDataReader rdrx = cmd.ExecuteReader();
            // Retrieve the Series to which we want to add DataPoints
            Series series = Chart2.Series["Series2"];
            // Loop thru each Student record
            while (rdrx.Read())
            {
                // Add X and Y values using AddXY() method
                series.Points.AddXY(rdrx["name"].ToString(),
                    rdrx["score"]);
            }

        }





        protected void btnDelete_Click(object sender, EventArgs e)
        {

            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("RecordDeleteByID", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ID", Convert.ToInt32(hfRecordID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            FillGridView();
            lblErrorMessage.Text = "Deleted Successfully";

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("CreateOrUpdateRecords", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ID", (hfRecordID.Value == "" ? 0 : Convert.ToInt32(hfRecordID.Value)));
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@roll", txtRole.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@score", txtScore.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            string contactID = hfRecordID.Value;
            Clear();
            if (contactID == "")
                lblSuccessMessage.Text = "Saved Successfully";
            else
                lblSuccessMessage.Text = "Updated Successfully";
            FillGridView();

        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int ID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("RecordViewByID", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@ID", ID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfRecordID.Value = ID.ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtRole.Text = dtbl.Rows[0]["Roll"].ToString();
            txtScore.Text = dtbl.Rows[0]["Score"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }
    }
    }
