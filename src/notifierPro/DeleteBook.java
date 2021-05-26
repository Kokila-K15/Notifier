package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/delete1")
public class DeleteBook extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
	{
		String notebook=request.getParameter("notebookname");
		System.out.println(notebook);
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		try {
			int result=NoteBookDao.delete(notebook,email);
			if(result==1)
			   response.sendRedirect("Notebooks.jsp");
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }
}
