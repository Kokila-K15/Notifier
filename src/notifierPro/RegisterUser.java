package notifierPro;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterUser extends HttpServlet{
    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		String username=request.getParameter("username");
		String email=request.getParameter("email");
		String mobile=request.getParameter("mobile");
		String password=request.getParameter("password");
		String cpassword=request.getParameter("cpassword");
		if(!password.equals(cpassword)) {
			request.setAttribute("errorMessage", "Password and Confirm password did not match.. Please check");
			RequestDispatcher rd=request.getRequestDispatcher("Register.jsp");  
		    rd.forward(request,response);  
		}
		else {
			RegisterDetails reg=new RegisterDetails();
			reg.setUsername(username);
			reg.setEmail(email);
			reg.setMobile(mobile);
			reg.setPassword(password);

			int status=RegisterDao.registerUser(reg);
			if(status!=0) {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp"); 
			rd.forward(request, response); 
			}
		}
	}
}
