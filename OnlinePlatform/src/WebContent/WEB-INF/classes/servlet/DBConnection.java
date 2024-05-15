package servlet;


	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.SQLException;

	public class DBConnection {
	    private static final String url = "jdbc:mysql://localhost:3306/app_store";
	    private static final String username = "root";
	    private static final String password = "DonMal12345.";

	    public static Connection getConnection() throws SQLException {
	        Connection connection = null;
	        
	        
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	        } 
	        catch (ClassNotFoundException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } 
	        
	        try {
	            connection = DriverManager.getConnection(url, username, password);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw e;
	        }
	        return connection;
	    }
	}



