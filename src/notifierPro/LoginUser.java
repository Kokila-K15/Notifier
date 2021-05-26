package notifierPro;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/login")
public class LoginUser extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		RegisterDetails reg=new RegisterDetails();
		reg.setEmail(email);
		reg.setPassword(password);
		try {
			String result=RegisterDao.loginUser(reg);
			if(!result.contentEquals("")) {
				HttpSession session=request.getSession();  
		        session.setAttribute("uname",result);  
		        session.setAttribute("uemail",email);  
		        int count=NotesDao.RemainderNotes(email);
				session.setAttribute("remcount", count);
				response.sendRedirect("Dashboard.jsp");
			}
			else
			{
				request.setAttribute("errorMessage1", "Invalid Login!");
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp"); 
				rd.forward(request, response); 
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}

}
