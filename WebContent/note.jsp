<html>
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <%@page import="notifierPro.NotesDao,notifierPro.NotesDetails"%>
    <%@page import="java.sql.*,java.util.*,java.util.Date,java.text.*,java.time.*"%>
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
 .notification {
  color: white;
  text-decoration: none;
  position: relative;
  display: inline-block;
}
 .badge{
 position:relative;
  top:-15px;
  right: 13px;
  padding: 5px 8px;
  border-radius: 50%;
  background-color: red;
  color: white;
   display: inline-block;
}
.modal.custom .modal-dialog {
    width:30%;
    margin:0 auto;
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
    	 $('body').on('click', '.edit',function(){
    	 document.getElementById("note_id").value = $(this).attr('data-id');
    	 console.log($(this).attr('data-id'));
    	 });
    	 });
     $(document).ready(function(){
   	  $('body').on('click', '.view',function(){
   		$.ajax({
   			url:"getData.jsp",
   			type:"post",
   			success:function(data){
   				$("#show-data").html(data);
   			}
   		});
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
 <%String n=(String)session.getAttribute("uname");%>
 <nav class="navbar navbar-inverse">
 <div class="container-fluid">
  <div class="navbar-header">
   <span class="menu" style="cursor:pointer;color:white" onclick="openNav()">&#9776</span>
    <span class="title">NOTIFIER</span>
  </div>
   <%
  int count=0;
  if(session.getAttribute("remcount")!=null)
  count=(Integer)session.getAttribute("remcount");%>
  <div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a class="active"><span class='fas fa-user-alt' style='font-size:25px;color:white'></span><%out.print(" Hi "+ n); %></a>
  <a href="Notebooks.jsp">Note Books</a>
  <a href="Dashboard.jsp">Notes</a>
  <a href="editUser.jsp">Edit User</a>
  </div>
  <ul class="nav navbar-nav navbar-right">
  <li><a href="#notes" data-toggle="modal" >New Note</a></li>
 <li><a href="#view-modal" data-toggle="modal" class="view" ><span class="fa fa-bell" class="notification" style="font-size:22px;color:white"> </span>
  <span class="badge"><%out.print(count); %></span>
 </a></li>
  <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
  </ul>
  </div>
  </nav>
  
  <div class="modal fade" id="notes" >
    <div class="modal-dialog">
      <div class="modal-content">
      <form method="post" action="<%= request.getContextPath() %>/notes">
        <div class="modal-header">
          <p class="modal-title" style="text-align:center">ADD NOTE<p>
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
         <div class="form-group">
         <input type="text" class="form-control" placeholder="Note Name" id="notename" name="notename">
         </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success" >Save</button>
        </div></form>
      </div>
    </div>
    </div>
   <div class="search" style="width:100vw;"> 
   <input id="container" type="text" placeholder="Search for notebooks.."class="input-material">&nbsp;<button ><i class="fa fa-search"></i></button>
  <br></div><br>
   <h3>Notes</h3>
    <%
    int notebook;
    if(request.getParameter("notebookname")!=null){
    String nbname=(String)request.getParameter("notebookname");
    notebook=Integer.parseInt(nbname);
    session.setAttribute("bookname", notebook);  } 
    else{
     notebook=(Integer)request.getAttribute("notebookname");
    }
    String email=(String)session.getAttribute("uemail");
    List<NotesDetails> list=NotesDao.ViewNotes(email, notebook);
   %>
   <div class="container">
    <%if(!list.isEmpty()){
    	for(NotesDetails name:list){%>
    		 <div class="notes" id="n">
    		 <a href='viewnotedetails.jsp?noteid=<%=name.getNoteid()%>'><% out.print(name.getNotename());%></a>&nbsp;&nbsp;
    		<% if(name.getStartdate()!=null){
    			 String sDate=name.getStartdate();
    			 String eDate=name.getEnddate();
    			 String rDate=name.getReminderdate();
    			 LocalDate todayDate = LocalDate.now();
    			 LocalDate startDate=LocalDate.parse(sDate);
    			 LocalDate endDate=LocalDate.parse(eDate);
    			 LocalDate remDate=LocalDate.parse(rDate);
    			 if(startDate.compareTo(todayDate) > 0) {
    				 out.print("Yet to start on "+startDate);
    				 %>
    				 &nbsp;<button type="button" class="btn btn-primary">Yet To Start</button>
    				 <%
    		      } 
    			 else if(todayDate.compareTo(endDate)> 0){
    				 out.print("Completed on "+endDate);
    				 %>
    				 &nbsp;<button type="button" class="btn btn-primary">Completed</button>
    				 <%
    			 }
    			 else{
    				 out.print("Started on "+startDate);
    				 %>
    				 &nbsp;<button type="button" class="btn btn-primary">Started</button>
    				 <%
    			 }
    			 
    			
    		 } %>
    		<br> <span class="glyphicon glyphicon-edit" style="background-color:white;border:none;color:blue;float:right;margin:5px;"><a href="#editnote" title="Edit" data-toggle="modal" data-id="<%=name.getNoteid() %>" class="edit" >Edit</a></span>
             <span class="glyphicon glyphicon-remove" style="background-color:white;border:none;color:blue;float:right;margin:5px;"><% out.print("<a href='deletenote?notename="+name.getNoteid()+"'>Delete</a>");  
             %></span> <br>
             <a href="#adddetails" title="add" data-toggle="modal" data-id="<%=name.getNoteid()%>" class="feed-id"><span class="glyphicon glyphicon-plus"></span></a>
    		 &nbsp;&nbsp;<span>
    		 <%if(name.getDescription()!=null) 
    		 out.print(name.getDescription()); %></span>
    		 </div><br>
    	<%}
    }
    else{
    	out.print(" Create your first notes.");
    }%>
    <br><br>
   
  </div>
  
    <!-- Add Details Modal HTML -->
    <div id="adddetails" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="<%= request.getContextPath() %>/addnotedetails">
                    <div class="modal-header">
                        <p class="modal-title" style="text-align:center">ADD NOTE DETAILS<p>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                      Start Date:
                        <div class="form-group">
                           <input type="date" class="form-control" placeholder="Start Date" id="startdate" name="startdate">
                        </div>
                      End Date:
                         <div class="form-group">
                           <input type="date" class="form-control" placeholder="End Date" id="enddate" name="enddate">
                        </div>
                      Remainder Date:
                         <div class="form-group">
                           <input type="date" class="form-control" placeholder="Remainder Date" id="remainderdate" name="remainderdate">
                        </div>
                         <div class="form-group">
                           <input type="text" class="form-control" placeholder="Status" id="status" name="status">
                        </div>
                         <div class="form-group">
                           <input type="text" class="form-control" placeholder="Tag" id="tag" name="tag">
                        </div>
                         <div class="form-group">
                           <input type="text" class="form-control" placeholder="Description" id="description" name="description">
                        </div>
                        </div>
                        <input type="hidden" id="feed_id" name="note-id" value="" />
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
            </div>
        </div>
    </div>  
    
     <!-- Edit Modal HTML -->
    <div id="editnote" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="<%= request.getContextPath() %>/editnote">
                    <div class="modal-header">
                          <p class="modal-title" style="text-align:center">EDIT NOTE<p>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                           <input type="text" class="form-control" placeholder="Note Name" id="newnote" name="newnote">
                        </div>
                        </div>
                        <input type="hidden" id="note_id" name="note_id" value="" />
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
            </div>
        </div>
    </div>  
      
      <div id="view-modal" class="modal custom fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display:none">
     <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                          <p class="modal-title" style="text-align:center">REMAINDER<p>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
            <div class="modal-body">
              <div id="show-data"></div>
            </div>
            </div>
             <div class="modal-footer">
                      <input type="button" class="btn btn-info" data-dismiss="modal" value="Close">
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