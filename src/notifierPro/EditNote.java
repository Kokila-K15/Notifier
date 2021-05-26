package notifierPro;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editnote")
public class EditNote extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String noteid=request.getParameter("note_id");
		int note_id=Integer.parseInt(noteid);
		String new_note=request.getParameter("newnote");
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		int book=0;
		  if(session.getAttribute("bookname")!=null)
		  book=(Integer)session.getAttribute("bookname");
		  int sample=0;
		  if(request.getParameter("sample")!=null)
			  sample=Integer.parseInt(request.getParameter("sample"));
	
		try {
			int res=NotesDao.editnotename(note_id,email,new_note);
			if(res==1) {
				if(sample==0){
				request.setAttribute("notebookname", book);
				RequestDispatcher rd=request.getRequestDispatcher("note.jsp");
				rd.forward(request, response);
				}
			    else {
			    	response.sendRedirect("Dashboard.jsp");
			    }
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
   }
}
