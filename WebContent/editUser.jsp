<html>
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
.container{
			margin-top: 7%;
			width: 400px;
			border: ridge 1.5px Black;
			padding: 20px;
			background-color:#F5F5F5;
			
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
  color:white;
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
  <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
  </ul>
  </div>
  </nav>
 <div class="container">
		<h2><strong>EDIT USER</strong></h2><br>
	<form action="<%= request.getContextPath() %>/edituser" method="post">
	<div class="form-group">
    <input type="text" class="form-control" placeholder="Username" id="username" name="username">
    </div>
    <div class="form-group">
    <input type="text" class="form-control" placeholder="Email" id="email" name="email">
    </div>
    <div class="form-group">
    <input type="text" class="form-control" placeholder="Mobile Number" id=mobilenum name="mobilenum">
    </div>
    <div class="form-group">
    <input type="password" class="form-control" placeholder="Password" id="password" name="password">
    </div>
  <button type="submit" id="but" class="btn btn-success" name="edit">Save</button>
</form>
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