package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deleteNotes")
public class AllNotesDelete extends HttpServlet{

	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request,HttpServletResponse response) {
    	
    	String note=request.getParameter("notename");
		int note_id=Integer.parseInt(note);
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		try {
			int result=NotesDao.delete(note_id,email);
			if(result==1) {
			  response.sendRedirect("Dashboard.jsp");
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
}
