package notifierPro;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/notes")
public class NotesServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
	  String notename=request.getParameter("notename");
	  HttpSession session=request.getSession();
	  int book=(Integer)session.getAttribute("bookname");
	  String email=(String)session.getAttribute("uemail");
	  NotesDetails note=new NotesDetails();
	  note.setNotename(notename);
	  note.setNotebookid(book);
	  note.setEmail(email);
	  try {
		  int res=NotesDao.addNotes(note);
		  if(res==1)
		  {
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
