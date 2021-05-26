package notifierPro;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deletenote")
public class DeleteNote extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request,HttpServletResponse response)
	{
		String note=request.getParameter("notename");
		int note_id=Integer.parseInt(note);
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		int book=(Integer)session.getAttribute("bookname");
		try {
			int result=NotesDao.delete(note_id,email);
			if(result==1) {
			request.setAttribute("notebookname", book);
			RequestDispatcher rd=request.getRequestDispatcher("note.jsp");
			rd.forward(request, response);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }
}
