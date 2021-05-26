<html>
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@page import="java.sql.*,java.util.*"%>
  <%@page import="notifierPro.NoteBookDao,notifierPro.NoteBookDetails"%>
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
 .search{
  text-align:right;
  margin-left:-125px;
 }
 .active{
  font-size:25px;
  font-weight:bold;
  background-color: #111;
 }
 h3{
  margin-left:110px;
 }
a:hover{
    text-decoration: none;
	list-style: none;
	color:blue;
 }
 a{
    text-decoration: none;
	list-style: none;
	color:blue;
 }
  </style>
     <script>
     $(document).ready(function () {
    	 $('body').on('click', '.feed-id',function(){
    	 document.getElementById("feed_id").value = $(this).attr('data-id');
    	 console.log($(this).attr('data-id'));
    	 });
    	 });
     
     $(document).ready(function () {
 	    function Contains(text_one, text_two) {
 	        if (text_one.indexOf(text_two) != -1){
 	            return true;
 	        }
 	    }
 	    $("#container").keyup(function () {
 	        var searchText = $("#container").val().toLowerCase();
 	        $(".notes").each(function () {
 	            if (!Contains($(this).text().toLowerCase(), searchText)) {
 	                $(this).hide();
 	            }
 	            else {
 	                $(this).show();
 	            }
 	        });
 	    });
 	});
    </script>
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
  <li><a href="#notebook" data-toggle="modal" >New Notebook</a></li>
  <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
  </ul></div>
  <div class="modal fade" id="notebook" >
    <div class="modal-dialog">
      <div class="modal-content">
      <form method="post" action="<%= request.getContextPath() %>/notebook">
        <div class="modal-header">
          <p class="modal-title" style="text-align:center">ADD NOTEBOOK<p>
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
         <div class="form-group">
         <input type="text" class="form-control" placeholder="Notebook Name" id="notebook1" name="notebook1">
         </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success" >Save</button>
        </div></form>
      </div>
    </div>
    </div>
  </nav>
 <div class="search" style="width:100vw;"> 
   <input id="container" type="text" placeholder="Search for notebooks.."class="input-material">&nbsp;<button ><i class="fa fa-search"></i></button>
  <br></div><br>
   <%
   String email=(String)session.getAttribute("uemail"); 
   List<NoteBookDetails> list=NoteBookDao.ViewNoteBook(email);
   %>
   <h3>Note Books</h3>

   <div class="container">
   <%
   if(!list.isEmpty()){
   for(NoteBookDetails s:list)
   {
   int count=NoteBookDao.totalNotes(s.getNotebookid(), email);
   %>
    <div class="notes" id="n">
   <a href='note.jsp?notebookname=<%=s.getNotebookid()%>'><% out.print(s.getNotebookname());%></a><br>
   <%out.print(count+" Notes"); %>
   <span class="glyphicon glyphicon-edit" style="background-color:white;border:none;color:blue;float:right;margin:5px;"><a href="#editnotebook" title="Edit" data-toggle="modal" data-id="<%=s.getNotebookname() %>" class="feed-id" >Edit</a></span>
   <span class="glyphicon glyphicon-remove" style="background-color:white;border:none;color:blue;float:right;margin:5px;"><% out.print("<a href='delete1?notebookname="+s.getNotebookname()+"'>Delete</a>");  
   %></span> 
   </div><br>
     <% 
     }
   }
   else
   out.print("Create your first notebook"); %>
  </div>
    <!-- Edit Modal HTML -->
    <div id="editnotebook" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="<%= request.getContextPath() %>/editbook">
                    <div class="modal-header">
                          <p class="modal-title" style="text-align:center">EDIT NOTEBOOK<p>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                           <input type="text" class="form-control" placeholder="Notebook Name" id="editname" name="editname">
                        </div>
                        </div>
                        <input type="hidden" id="feed_id" name="book_id" value="" />
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
            </div>
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