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
  </style>
  </head>
  
 <body>
 <nav class="navbar navbar-inverse">
 <div class="container-fluid">
  <div class="navbar-header">
   <span class="menu" style="cursor:pointer;color:white" onclick="openNav()">&#9776</span>
    <span class="title">NOTIFIER</span>
  </div>
  
</div>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="#"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
  </ul>
 </div>
 </nav>
 <div class="container">
		<h2><strong>Register</strong></h2><br>
	<form action="<%= request.getContextPath() %>/register" method="post">
	<div class="form-group">
    <input type="text" class="form-control" placeholder="Username" id="username" name="username">
    </div>
    <div class="form-group">
    <input type="text" class="form-control" placeholder="Email" id="email" name="email">
    </div>
    <div class="form-group">
    <input type="text" class="form-control" placeholder="Mobile Number" id="mobile" name="mobile">
    </div>
    <div class="form-group">
    <input type="password" class="form-control" placeholder="Password" id="password" name="password">
    </div>
    <div class="form-group">
    <input type="password" class="form-control" placeholder="Confirm Password" id="cpassword" name="cpassword">
    </div>
  <button type="submit" id="but" class="btn btn-success" name="login">Sign Up</button>
   <div style="color:red; text-align:center" id=error>${errorMessage}</div>
  <p id="mem">Already a member?<a href="index.jsp"> Sign In</a></p>
</form>
</div>
 </body>
</html>