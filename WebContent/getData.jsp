<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
.notes1{
  text-align:center;
}
</style>
</head>
<body>
<div class="notes1">
<% 
if(session.getAttribute("uemail")==null) 
	   response.sendRedirect("index.jsp");
String email=(String)session.getAttribute("uemail");
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/notifierpro", "root", "dolphine2020");
try{
PreparedStatement ps=conn.prepareStatement("select * from notes where email='"+email+"' and remainderdate=CURDATE()");
ResultSet rs=ps.executeQuery();
if (rs.next() == false)
   out.print("No Remainder");
else{
	 while(rs.next()){%>
	 <span style="color:blue"><%out.print(rs.getString("notename"));%></span><br>
	 <%out.print("("+rs.getString("remainderdate")+")");
	 %><hr>
<%
  }%> 
<% 
}}
catch(Exception e){
	System.out.print(e);
}
%></div>
</body>
</html>