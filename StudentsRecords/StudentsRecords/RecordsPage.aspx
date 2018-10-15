<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordsPage.aspx.cs" Inherits="StudentsRecords.RecordsPage" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <style>
     body {
         background-color:#f1f1f1;
     }
 </style>
   
</head>
<body>
    <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Our Students Database System</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="RecordsPage.apax"> Students Records</a></li>
      
    </ul>
  </div>
</nav>
  
    <div class="container">
    
     
         <form id="form1" runat="server">
        <div class="row">
        <div class="col-md-6">

   
             <div>

            <asp:HiddenField ID="hfRecordID" runat="server" />
            </div>

<div class="row">
    <div class="col-md-12">
        
     <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="XX-Large" ForeColor="Black" Text="STUDENTS RECORD"></asp:Label>
           
                    </div>
    </div>



            <div class="row">
                    <div class="col-md-12">
                   <h3>Name</h3>
                   
                    
                
                     <asp:TextBox ID="txtName" runat="server" Height="27px" hint="ENTER NAME" CssClass="form-control" ></asp:TextBox>
                        </div>
                 
                    </div>
    
            <div class="row">
          
                <div class="col-md-12">
                   <h3> Roll </h3><asp:TextBox ID="txtRole" runat="server" Height="27px" hint="ENTER ROLL NO" CssClass="form-control"  ></asp:TextBox>
                </div>
            </div>
                
                
                <div class="row">
          
                <div class="col-md-12">
                  <h3>  Test Score</h3>

                      
                      <asp:TextBox ID="txtScore" runat="server" Height="27px" hint="ENTER TEST SCORE" CssClass="form-control" ></asp:TextBox>
               </div>
                </div>

            <div class="row" style="height:50px" ></div>
            <div class="row">
          
                <div class="col-md-4">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"  Width="182px"  Font-Bold="True" Font-Size="Larger"  CssClass="btn btn-success"   />
               </div>
                <div class="col-md-4">
                    <asp:Button ID="btnDelete" runat="server" Text="Delete"  OnClick="btnDelete_Click"  Width="182px"    Font-Bold="True" Font-Size="Larger"  CssClass="btn btn-danger" />
               </div>
                <div class="col-md-4">
                    <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click"  Width="181px"   Font-Bold="True" Font-Size="Larger" ForeColor="White" CssClass="btn btn-primary" />
                </div>
            </div>
        
            <div class="row"  >
                <div class="col-md-12">
                <asp:Label ID="lblSuccessMessage" runat="server" ForeColor="Green" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                </div>
            </div>
     
              
              <div class="row"  >
                <div class="col-md-12">
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Font-Bold="True" Font-Size="X-Large"></asp:Label>
              </div>
                  </div>
            
        

      
    
  </div>
                  
      <div class="col-md-6">
          <div class="row" style="height:50px" ></div>

                        <asp:GridView ID="gvRecords" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#6699FF" BorderStyle="Solid" BorderWidth="5px" ForeColor="#333333" GridLines="Horizontal" Height="221px" ShowFooter="True" Width="497px" >
            <Columns>
                <asp:BoundField DataField="name" HeaderText="Name" />
                <asp:BoundField DataField="roll" HeaderText="Roll" />
                <asp:BoundField DataField="score" HeaderText="Score" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("id") %>' OnClick="lnk_OnClick">Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="#9999FF" />
        </asp:GridView>
                        </div>
</div>
        </form>
            <div class="row" style="height:50px" ></div>
        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">Data Visualize</button>
        <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog ">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Charts</h4>
        </div>
        <div class="modal-body">


      <asp:Chart ID="Chart1" runat="server" Width="468px"  >
    <Titles>
        <asp:Title Text="Total Score of students"></asp:Title>
    </Titles>
    <Series>
        <asp:Series Name="Series1">
            <Points>
                
            </Points>
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisX Title="Student Name"></AxisX>
            <AxisY Title="Total Marks"></AxisY>
        </asp:ChartArea>
    </ChartAreas>
</asp:Chart>
            <hr />
            <asp:Chart ID="Chart2" runat="server" Width="468px" ChartType="Pie" >
    <Titles>
        <asp:Title Text="Total Score of students"></asp:Title>
    </Titles>
    <Series>
        <asp:Series Name="Series2" ChartType="Pie">
            <Points>
                
            </Points>
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisX Title="Student Name"></AxisX>
            <AxisY Title="Total Marks"></AxisY>
        </asp:ChartArea>
    </ChartAreas>
</asp:Chart>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
        
      

        </div>
    
    
</body>
</html>
