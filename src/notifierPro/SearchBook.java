package notifierPro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;

@WebServlet("/searchbook")
public class SearchBook extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{
		String bookname=request.getParameter("search");
		HttpSession session=request.getSession();  
		String email=(String)session.getAttribute("uemail"); 
		List<NoteBookDetails> list=new ArrayList<NoteBookDetails>();
	    try {
	        list=NoteBookDao.getBook(bookname,email);
	        response.sendRedirect("Notebooks.jsp");
	    }
	    catch(Exception e) {
	    	System.out.println(e);
	    }
	}
}
