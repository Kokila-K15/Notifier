package notifierPro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RegisterDao {

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
	
	public static int registerUser(RegisterDetails reg) {
		String sql="insert into user(username,email,mobile,password)values"+"(?,?,?,?)";
		int result = 0;
		try {
		     Connection connection=RegisterDao.getConnection();
		
		     PreparedStatement preparedStatement = connection.prepareStatement(sql); 
			 preparedStatement.setString(1, reg.getUsername());
			 preparedStatement.setString(2, reg.getEmail());
			 preparedStatement.setString(3, reg.getMobile());
			 preparedStatement.setString(4, reg.getPassword());

			 result = preparedStatement.executeUpdate();
			
		}
		 catch (Exception e) {
	           e.printStackTrace();
	        }
	        return result;
	}
	public static String loginUser(RegisterDetails reg) {
		String sql="select * from user where email=? and password=?";
		String name="";
		try {
			Connection connection=RegisterDao.getConnection();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1,reg.getEmail());
			ps.setString(2,reg.getPassword());
			ResultSet rs=ps.executeQuery();
			rs.next();
			
			if(rs.getRow()!=0)
				name=rs.getString(2);
			}
		catch(Exception e) {
			System.out.println(e);
		}
		return name;
	}

	public static int editUser(RegisterDetails reg, String uemail) {
		String sql="UPDATE user SET username=?,email=?,mobile=?,password=? WHERE email=?";
		int res=0;
		try {
			Connection connection=RegisterDao.getConnection();
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1,reg.getUsername());
			ps.setString(2,reg.getEmail());
			ps.setString(3,reg.getMobile());
			ps.setString(4,reg.getPassword());
			ps.setString(5,uemail);
			res=ps.executeUpdate();		
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return res;
	}
}
