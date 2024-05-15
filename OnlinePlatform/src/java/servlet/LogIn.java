package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogIn")
public class LogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Use your DBConnection to get a database connection
        Connection connection = null;
	      try {
	    	  connection = DBConnection.getConnection();
		      if (connection != null) {
		         
		                // Prepare a SQL query to check the user's credentials
		                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
		                PreparedStatement preparedStatement = connection.prepareStatement(sql);
		                preparedStatement.setString(1, username);
		                preparedStatement.setString(2, password);
		                ResultSet resultSet = preparedStatement.executeQuery();
		
		                if (resultSet.next()) {
		                    // Login successful
		                    HttpSession session = request.getSession();
		                    session.setAttribute("id", resultSet.getInt("id"));
		                    session.setAttribute("isAdmin", resultSet.getBoolean("isAdmin"));
		                    session.setAttribute("username", resultSet.getString("username"));
		                    session.setAttribute("email", resultSet.getString("email"));
		                    session.setAttribute("firstname", resultSet.getString("first_name"));
		                    session.setAttribute("jdate", resultSet.getString("joined_date"));
		
		                    // JavaScript for success alert
		                    String successMessage = "Login Successful!";
		                    response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'home.jsp';</script>");
		                    
		                } 
		                else {
		                    // Invalid credentials
		                	 String invalidMessage = "Invalid Username or Password";
		                     response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'login.jsp';</script>");
		                }
		            } 
		        else {
		        	response.getWriter().println("Failed to connect to the database.");
		        }
		    } 
		     catch (SQLException e) {
		            e.printStackTrace();
		            // Handle the SQL exception here
		           } 
		     finally {
		            try {
		                connection.close(); // Close the database connection
		            } 
		            catch (SQLException e) {
		                e.printStackTrace();
		            }
		      }
	       
	       
	   }
}
