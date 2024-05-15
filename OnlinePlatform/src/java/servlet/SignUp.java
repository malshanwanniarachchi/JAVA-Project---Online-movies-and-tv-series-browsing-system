package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Get the current date for joined_date
        Date joinedDate = new Date();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
      
        
        try {
	    	  connection = DBConnection.getConnection();
		      if (connection != null) {
	                // Prepare an SQL insert statement
	                String insertSQL = "INSERT INTO users (first_name, last_name, email, username, password, joined_date) VALUES (?, ?, ?, ?, ?, ?)";
	                preparedStatement = connection.prepareStatement(insertSQL);
	                preparedStatement.setString(1, firstName);
	                preparedStatement.setString(2, lastName);
	                preparedStatement.setString(3, email);
	                preparedStatement.setString(4, username);
	                preparedStatement.setString(5, password);
	                preparedStatement.setTimestamp(6, new java.sql.Timestamp(joinedDate.getTime()));

	                // Execute the SQL statement
	                int rowsInserted = preparedStatement.executeUpdate();

	                if (rowsInserted > 0) {
	                    // Registration was successful
	                	 String successMessage = "Registration Successful!";
		                 response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'home.jsp';</script>");
	                } else {
	                    // Registration failed
	                	String invalidMessage = "Registration Failed!";
	                    response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'Signup.jsp';</script>");
	                }
		      
		      }
		      
		      else {
		            // Handle the case where the database connection couldn't be established // Handle the case where the database connection couldn't be established
		    	  	response.getWriter().println("Failed to connect to the database.");
		        }
            } 
	    catch (SQLException e) {
                e.printStackTrace();
                // Handle database errors
            } 
        finally {
        	
	        	try {
	                if (preparedStatement != null) {
	                    preparedStatement.close();
	                }
	                if (connection != null) {
	                    connection.close();
	                }
	        	} 
	        	catch (SQLException e) {
	                e.printStackTrace();
	                // Handle database errors
	            }
        	}
        } 
    }

