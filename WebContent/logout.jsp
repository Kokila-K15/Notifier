<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function myFunction() {
      gapi.auth2.getAuthInstance().disconnect();
      location.reload();
   }
</script>
<%  
session.removeAttribute("uemail");
session.invalidate();
response.sendRedirect("index.jsp");
%>
</body>
</html>