package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editbook")
public class EditNoteBook extends HttpServlet{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String notebook=request.getParameter("book_id");
		String newbook=request.getParameter("editname");
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
	
		try {
			int res=NoteBookDao.editbook(notebook,email,newbook);
			if(res==1) {
				response.sendRedirect("Notebooks.jsp");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }

}
