package notifierPro;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addnotedetails")
public class AddNoteDetails extends HttpServlet{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		  String notename=request.getParameter("note-id");
		  int noteid=Integer.parseInt(notename);
		  HttpSession session=request.getSession();
		  int book=0;
		  if(session.getAttribute("bookname")!=null)
		  book=(Integer)session.getAttribute("bookname");
		  int sample=0;
		  if(request.getParameter("sample")!=null)
			  sample=Integer.parseInt(request.getParameter("sample"));
		  String email=(String)session.getAttribute("uemail");
		  String startdate=request.getParameter("startdate");
		  String enddate=request.getParameter("enddate");
		  String remainderdate=request.getParameter("remainderdate");
		  String status=request.getParameter("status");
		  String tag=request.getParameter("tag");
		  String description=request.getParameter("description");
		  NotesDetails nd=new NotesDetails();
		  nd.setNoteid(noteid);
		  nd.setNotebookid(book);
		  nd.setEmail(email);
		  nd.setStartdate(startdate);
		  nd.setEnddate(enddate); 
		  nd.setReminderdate(remainderdate);
		  nd.setStatus(status);
		  nd.setTag(tag);
		  nd.setDescription(description);
		  try {
			  int res=NotesDao.updateDetails(nd);
			  //System.out.println(book+" "+sample);
			  if(res==1)
			  {
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
