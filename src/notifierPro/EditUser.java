package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/edituser")
public class EditUser extends HttpServlet{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String username=request.getParameter("username");
		String mobilenum=request.getParameter("mobilenum");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		HttpSession session=request.getSession();  
		String uemail=(String)session.getAttribute("uemail"); 
		RegisterDetails reg=new RegisterDetails();
		reg.setUsername(username);
		reg.setMobile(mobilenum);
		reg.setEmail(email);
		reg.setPassword(password);
		try {
			int res=RegisterDao.editUser(reg,uemail);
			if(res==1) {
				session.setAttribute("uname",username);  
				session.setAttribute("uemail",email);  
				response.sendRedirect("Dashboard.jsp");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }

}
