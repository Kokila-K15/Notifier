package notifierPro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class NoteBookDao {

	public static Connection getConnection()
	{
		Connection connection=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost/notifierpro","root", "dolphine2020");
			}
	    catch (Exception e)
			{
				e.printStackTrace();
			}
		return connection;
	}
	public static List<NoteBookDetails> ViewNoteBook(String email)
	{
		List<NoteBookDetails> list=new ArrayList<NoteBookDetails>();
		String sql="select * from notebook where email=?";
		try {
			Connection connection=NoteBookDao.getConnection();	
		    PreparedStatement ps = connection.prepareStatement(sql); 
		    ps.setString(1,email);
		    ResultSet rs=ps.executeQuery();
		    while(rs.next()) {
		    	NoteBookDetails nb=new NoteBookDetails();
		    	int id=rs.getInt(1);
		    	String name=rs.getString(2);
		    	nb.setNotebookid(id);
		    	nb.setNotebookname(name);
		    	list.add(nb);
		    }
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return list;		
	}
	public static int addNoteBook(String notebook, String email) {
		String sql="insert into notebook (nbname,email)values"+"(?,?)";
		int res=0;
		try {
			Connection connection=NoteBookDao.getConnection();	
		    PreparedStatement ps = connection.prepareStatement(sql); 
		    ps.setString(1,notebook);
		    ps.setString(2,email);
		    res=ps.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return res;
	}
	public static int delete(String notebook, String email)
	{
		String sql1="delete from notebook where email=? and nbname=?";
		String sql="select nbid from notebook where email=? and nbname=?";
		String str="delete from notes where email=? and notebookid=?";
		int result=0;
		try {
			Connection connection=NoteBookDao.getConnection();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,notebook);
			ResultSet rs=ps.executeQuery();
			int id=0;
			if(rs.next())
				id=rs.getInt("nbid");
			if(id!=0) {
				PreparedStatement ps1=connection.prepareStatement(sql1);
				ps1.setString(1,email);
				ps1.setString(2,notebook);
				ps1.executeUpdate();
				PreparedStatement ps2=connection.prepareStatement(str);
				ps2.setString(1,email);
				ps2.setInt(2,id);
				result=ps2.executeUpdate();
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return result;
	}
	public static int editbook(String notebook,String email, String newbook) {
		String sql="UPDATE notebook SET nbname=? WHERE email=? and nbname=?";
		int result=0;
        try {
        	Connection connection=NoteBookDao.getConnection();
        	PreparedStatement ps=connection.prepareStatement(sql);
        	ps.setString(1,newbook);
			ps.setString(2,email);
			ps.setString(3,notebook);
			result=ps.executeUpdate();
        }
        catch(Exception e) {
        	System.out.print(e);
        }
        return result;
	}
	public static int totalNotes(int notebookid,String email) {
		String sql="SELECT COUNT(noteid) as totalnotes FROM notes WHERE email=? and notebookid=?";
		int count=0;
        try {
        	Connection connection=NoteBookDao.getConnection();
        	PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1,email);
			ps.setInt(2,notebookid);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count = rs.getInt("totalnotes") ;
        }
        catch(Exception e) {
        	System.out.print(e);
        }
        return count;
	}
	public static List<NoteBookDetails> getBook(String bookname,String email) {
		String sql="select * from notebook where nbname=? and email=?";
		List<NoteBookDetails> list=new ArrayList<NoteBookDetails>();
		try {
			Connection connection=NoteBookDao.getConnection();
        	PreparedStatement ps=connection.prepareStatement(sql);
        	ps.setString(1,bookname);
        	ps.setString(2,email);
        	ResultSet rs=ps.executeQuery();
        	while(rs.next()) {
        		NoteBookDetails nb=new NoteBookDetails();
		    	String name=rs.getString(2);
		    	nb.setNotebookname(name);
		    	list.add(nb);
        	}
		}
		 catch(Exception e) {
	        	System.out.print(e);
	        }
		return list;
		
		
	}
}
