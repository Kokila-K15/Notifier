<html>
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <%@page import="notifierPro.NotesDao,notifierPro.NotesDetails"%>
    <%@page import="java.sql.*,java.util.*"%>
  <style>
  .container{
			margin-top: 2%;
			width: 85%;
			border: ridge 1.5px Black;
			padding: 15px;
			background-color:#F5F5F5;			
    }
    .notes{
       width: 100%;
	   border: ridge 1.5px Black;
	   padding: 20px;
	   background-color:white;	
    }
	h2{
	  text-align:center;
	  color:MediumSeaGreen;
	}	
	#but{
	  margin: 8px 150px;
	}	
	#mem{
	  text-align:center;
	  text-decoration: none;
	}
.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 20px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #f1f1f1;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}
 .menu {
  font-size:30px;
  margin-left:12px;
 }
 .menu a:hover{
 text-decoration: none;
	list-style: none;
 }
.title{
position:relative;  color: red;font-weight:bold; margin-left:10px;font-size:25px;
 }
 h4{
  position: absolute;
  right: 150px;
 }
 .active{
  font-size:25px;
  font-weight:bold;
  background-color: #111;
 }
  h3{
  margin-left:230px;
 }
 .dis{
  margin-left:230px;
 }
  </style>
  </head>
  
 <body>
 <% 
if(session.getAttribute("uemail")==null) 
	   response.sendRedirect("index.jsp");
 %>
 <%String n=(String)session.getAttribute("uname");   %>
 <nav class="navbar navbar-inverse">
 <div class="container-fluid">
  <div class="navbar-header">
   <span class="menu" style="cursor:pointer;color:white" onclick="openNav()">&#9776</span>
    <span class="title">NOTIFIER</span>
  </div>
  <div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a class="active"><span class='fas fa-user-alt' style='font-size:25px;color:white'></span><%out.print(" Hi "+ n); %></a>
  <a href="Notebooks.jsp">Note Books</a>
  <a href="Dashboard.jsp">Notes</a>
  <a href="editUser.jsp">Edit User</a>
  </div>
  <ul class="nav navbar-nav navbar-right">
  <li><a href="" class="fa fa-bell" style="font-size:22px;color:white"></a></li>
  <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
  </ul>
  </div>
  </nav>
  <h3>Note</h3>
   <div class="note">
   <%
   String note_id=request.getParameter("noteid");
   String str[]=note_id.split(" ");
   int id=0,sample=0;
   if(str.length==2){
    id=Integer.parseInt(str[0]);
    sample=Integer.parseInt(str[1]);
   }
   else
	   id=Integer.parseInt(str[0]);
   String email=(String)session.getAttribute("uemail");
   List<NotesDetails> details = NotesDao.ViewNoteDetails(email,id);%>
   <table class="table table-striped" style="width:70%; margin: 0 auto;"> <tbody><tr>
   <%int noteid=0; %>
   <%for(NotesDetails e:details){  
	   noteid=e.getNotebookid();
	   %>
      <tr>
        <td>Name</td>
        <td><%out.print(e.getNotename()); %></td>
      </tr>
      <tr>
        <td>Start Date</td>
        <td><%out.print(e.getStartdate()); %></td>
      </tr>
      <tr>
        <td>End Date</td>
        <td><%out.print(e.getEnddate()); %></td>
      </tr>
      <tr>
        <td>Remainder Date</td>
        <td><%out.print(e.getReminderdate()); %></td>
      </tr>
      <tr>
        <td>Status</td>
        <td><%out.print(e.getStatus()); %></td>
      </tr>
      <tr>
        <td>Tag</td>
        <td><%out.print(e.getTag()); %></td>
      </tr>
      <tr>
        <td>Description</td>
        <td><%out.print(e.getDescription()); %></td>
      </tr>
   <%} %>
  </tbody></table>
  <div class="dis">
       <%
       if(sample!=1)
       out.print("<a href='note.jsp?notebookname="+noteid+"'>Back</a>");
       else
        out.print("<a href='Dashboard.jsp?notebookname="+noteid+"'>Back</a>");%>
  </div>
  </div>
<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "200px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
 </body>
</html>