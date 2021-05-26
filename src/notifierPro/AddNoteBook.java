package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/notebook")
public class AddNoteBook extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String notebook=request.getParameter("notebook1");
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		//System.out.println(notebook);
		try {
			int res=NoteBookDao.addNoteBook(notebook,email);
			if(res==1) {
				response.sendRedirect("Notebooks.jsp");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }
}
