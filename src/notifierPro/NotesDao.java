package notifierPro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.*;

public class NotesDao {
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

public static int addNotes(NotesDetails note) {
	
	String sql="insert into notes (notename,notebookid,email)values"+"(?,?,?)";
	int res=0;
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ps.setString(1,note.getNotename());
	    ps.setInt(2,note.getNotebookid());
	    ps.setString(3,note.getEmail());
	    res=ps.executeUpdate();
	    System.out.println("ji");
	}
	 catch(Exception e) {
		  System.out.println(e);
	  }
	return res;
}

public static List<NotesDetails> ViewNotes(String email,int notebook) {
	
	String sql="select * from notes where email='"+email+"' and notebookid='"+notebook+"'";
	List<NotesDetails> list=new ArrayList<NotesDetails>();
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
//	    ps.setString(1,email);
//	    ps.setInt(2,notebook);
	    ResultSet rs=ps.executeQuery(sql);
	    while(rs.next()) {
	    	NotesDetails nb=new NotesDetails();
	    	nb.setNoteid(rs.getInt("noteid"));
	    	nb.setNotename(rs.getString("notename"));
	    	nb.setDescription(rs.getString("description"));
	    	nb.setStartdate(rs.getString("startdate"));
	    	nb.setEnddate(rs.getString("enddate"));
	    	nb.setReminderdate(rs.getString("remainderdate"));
	    	list.add(nb);
	    }
	}
	catch(Exception e) {
		System.out.println(e);
	}
	return list;
  }

public static int updateDetails(NotesDetails nd) {
	String sql="UPDATE notes SET startdate=?,enddate=?,remainderdate=?,status=?,tag=?,description=? WHERE email=? and noteid=?";
	int res=0;
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ps.setString(1,nd.getStartdate());
	    ps.setString(2,nd.getEnddate());
	    ps.setString(3,nd.getReminderdate());
	    ps.setString(4,nd.getStatus());
	    ps.setString(5,nd.getTag());
	    ps.setString(6,nd.getDescription());
	    ps.setString(7,nd.getEmail());
	    ps.setInt(8,nd.getNoteid());
	    res=ps.executeUpdate();
	   
	}
	 catch(Exception e) {
		  System.out.println(e);
	  }
	return res;
}

public static int editnotename(int note_id, String email, String new_note) {

	String sql="update notes set notename=? where noteid=? and email=?";
	int res=0;
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ps.setString(1,new_note);
	    ps.setInt(2,note_id);
	    ps.setString(3,email);
	    res=ps.executeUpdate();
	}
	 catch(Exception e) {
		  System.out.println(e);
	  }
	return res;
}

public static int delete(int note_id, String email) {
	String sql="delete from notes where noteid=? and email=?";
	int res=0;
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ps.setInt(1,note_id);
	    ps.setString(2,email);
	    res=ps.executeUpdate();
	}
	 catch(Exception e) {
		  System.out.println(e);
	  }
	return res;
}

public static List<NotesDetails> ViewNoteDetails(String email,int noteid) {
	
	String sql="select * from notes where email='"+email+"' and noteid='"+noteid+"'";
	List<NotesDetails> list=new ArrayList<NotesDetails>();
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ResultSet rs=ps.executeQuery(sql);
	    while(rs.next()) {
	    	NotesDetails nb=new NotesDetails();
	    	nb.setNotebookid(rs.getInt("notebookid"));
	    	nb.setNotename(rs.getString("notename"));
	    	String sDate=rs.getString("startdate");
	    	String eDate=rs.getString("enddate");
	    	LocalDate todayDate = LocalDate.now();
			 LocalDate startDate=LocalDate.parse(sDate);
			 LocalDate endDate=LocalDate.parse(eDate);
			 if(startDate.compareTo(todayDate) > 0) {
				 nb.setStatus("Not Started");
			 }
			 else if(todayDate.compareTo(endDate)> 0) {
				 nb.setStatus("Completed");
			 }
			 else {
				 nb.setStatus("Started");
			 }
	    	nb.setStartdate(rs.getString("startdate"));
	    	nb.setEnddate(rs.getString("enddate"));
	    	nb.setReminderdate(rs.getString("remainderdate"));
	    	nb.setTag(rs.getString("tag"));
	    	nb.setDescription(rs.getString("description"));
	    	list.add(nb);
	    }
	}
	catch(Exception e) {
		System.out.println(e);
	}
	return list;
  }
  
public static List<NotesDetails> allNotes(String email) {
	
	String sql="select * from notes where email='"+email+"'";
	List<NotesDetails> list=new ArrayList<NotesDetails>();
	try {
		Connection connection=NoteBookDao.getConnection();	
	    PreparedStatement ps = connection.prepareStatement(sql);
	    ResultSet rs=ps.executeQuery(sql);
	    while(rs.next()) {
	    	NotesDetails nb=new NotesDetails();
	    	nb.setNoteid(rs.getInt("noteid"));
	    	nb.setNotename(rs.getString("notename"));
	    	nb.setNotebookid(rs.getInt("notebookid"));
	    	nb.setStartdate(rs.getString("startdate"));
	    	nb.setEnddate(rs.getString("enddate"));
	    	nb.setReminderdate(rs.getString("remainderdate"));
	    	list.add(nb);
	    }
	}
	catch(Exception e) {
		System.out.println(e);
	}
	return list;
  }

public static int RemainderNotes(String email) {
	String sql="SELECT COUNT(noteid) as notecount FROM notes WHERE email=? and remainderdate=CURDATE()";
	int res=0;
	try {
		Connection connection=NoteBookDao.getConnection();
    	PreparedStatement ps=connection.prepareStatement(sql);
		ps.setString(1,email);
		ResultSet rs=ps.executeQuery();
		rs.next();
		res = rs.getInt("notecount") ;
		System.out.println(res);
    }
    catch(Exception e) {
    	System.out.print(e);
    }
    return res;
	
}
}
