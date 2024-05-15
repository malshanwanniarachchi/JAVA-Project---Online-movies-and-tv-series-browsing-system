package servlet;


import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AccountSettings")
public class AccountSettings extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
       
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");
        
        Connection connection = null;
        
        

        if ("u".equals(action)) {
        	
            // Use DBConnection to establish a database connection
        	
            try {
            
            	connection = DBConnection.getConnection();
         
            	// Retrieve form data
            	String fullName = request.getParameter("fullname");
            	String gender = request.getParameter("gender");
            	String dob = request.getParameter("dob");
            	String country = request.getParameter("country");
            	String address = request.getParameter("address");
            	String zipcode = request.getParameter("zipcode");
            	
                
                // Prepare an SQL statement and update user information in the database
                String sql = "UPDATE account_details SET fullname=?, gender=?, dob=?, country=?, address=?, zipcode=? WHERE userid=?";
                PreparedStatement preparedStatement1 = connection.prepareStatement(sql);
                preparedStatement1.setString(1, fullName);
                preparedStatement1.setString(2, gender);
                preparedStatement1.setString(3, dob);
                preparedStatement1.setString(4, country);
                preparedStatement1.setString(5, address);
                preparedStatement1.setString(6, zipcode);
                preparedStatement1.setInt(7, userId); // Replace with actual code to get the user ID from the session
                
                int rowsUpdated = preparedStatement1.executeUpdate();
                
                preparedStatement1.close();
                connection.close();
                
                if (rowsUpdated > 0) {
                    // Update successful
                	 String successMessage = "Update Successful!";
	                 response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'account_settings.jsp';</script>");
                } else {
                    // Handle update failure
                	String invalidMessage = "Update Failed!";
                    response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'account_settings.jsp';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
            
            
        } else if ("password".equals(action)) {
            // Handle password change logic here
            // Use DBConnection to establish a database connection
            try {
                connection = DBConnection.getConnection();
                
                // Retrieve form data
                String prevPassword = request.getParameter("prevPassword");
                String newPassword = request.getParameter("newPassword");
                
                // Check the previous password
                if (isPreviousPasswordValid(userId, prevPassword)) {
                    // Update the password
                    String sql = "UPDATE users SET password=? WHERE id=?";
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, newPassword);
                    preparedStatement.setInt(2, userId); // Replace with actual code to get the user ID from the session
                    
                    int rowsUpdated = preparedStatement.executeUpdate();
                    
                    preparedStatement.close();
                    connection.close();
                    
                    if (rowsUpdated > 0) {
                        // Password change successful
                        String PassSuccessfulMessage = "Password Change Succefull!";
                        response.getWriter().println("<script>alert('" + PassSuccessfulMessage + "'); window.location = 'account_settings.jsp';</script>");
                    } else {
                        // Handle password change failure
                    	String invalidMessage = "Password Change Failed!";
                    	 response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'account_settings.jsp';</script>");
                    }
                } else {
                    // Handle incorrect previous password
                	String invalidMessage2 = "incorrect old password";
                	 response.getWriter().println("<script>alert('" + invalidMessage2 + "'); window.location = 'account_settings.jsp';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
        }
        
        else if ("deleteAccount".equals(action)) {
            // Handle account deletion logic here
            try {
                connection = DBConnection.getConnection();

                // Delete user account and related data
                String deleteUserDataSQL = "DELETE FROM account_details WHERE userid=?";
                String deleteUserCardSQL = "DELETE FROM card WHERE userid=?";
                String deleteUserContentSQL = "DELETE FROM app WHERE userid=?";
                String deleteUserSQL = "DELETE FROM users WHERE id=?";
                
                // Create prepared statements for account details and user deletion
                PreparedStatement preparedStatementDeleteData = connection.prepareStatement(deleteUserDataSQL);
                preparedStatementDeleteData.setInt(1, userId);
                
                PreparedStatement preparedStatementDeleteCard = connection.prepareStatement(deleteUserCardSQL);
                preparedStatementDeleteCard.setInt(1, userId);
                
                PreparedStatement preparedStatementDeleteContent = connection.prepareStatement(deleteUserContentSQL);
                preparedStatementDeleteContent.setInt(1, userId);
                
                PreparedStatement preparedStatementDeleteUser = connection.prepareStatement(deleteUserSQL);
                preparedStatementDeleteUser.setInt(1, userId);

                // Execute the deletion queries
                int rowsDeletedData = preparedStatementDeleteData.executeUpdate();
                int rowsDeletedCard = preparedStatementDeleteCard.executeUpdate();
                int rowsDeletedContent = preparedStatementDeleteContent.executeUpdate();
                int rowsDeletedUser = preparedStatementDeleteUser.executeUpdate();
                
                // Close prepared statements and the database connection
                preparedStatementDeleteData.close();
                preparedStatementDeleteCard.close();
                preparedStatementDeleteContent.close();
                preparedStatementDeleteUser.close();
                connection.close();

                // Check if both deletion queries were successful
                if ( rowsDeletedData > 0 || rowsDeletedUser > 0 ||rowsDeletedCard > 0 || rowsDeletedContent > 0) {
                    // Account deletion successful
                    session.invalidate(); // Log out the user after account deletion
                    String deleteSuccessMessage = "Account Deleted Successfully!";
                    response.getWriter().println("<script>alert('" + deleteSuccessMessage + "'); window.location = 'login.jsp';</script>");
                } else {
                    // Handle account deletion failure
                    String deleteErrorMessage = "Account Deletion Failed!";
                    response.getWriter().println("<script>alert('" + deleteErrorMessage + "'); window.location = 'account_settings.jsp';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
        }
        
        else if ("a".equals(action)) {
            // Handle add logic
            try {
                connection = DBConnection.getConnection();

                // Retrieve form data
                String fullName = request.getParameter("fullname");
                String gender = request.getParameter("gender");
                String dob = request.getParameter("dob");
                String country = request.getParameter("country");
                String address = request.getParameter("address");
                String zipcode = request.getParameter("zipcode");

                // Prepare an SQL statement to insert a new account record
                String sql = "INSERT INTO account_details (userid, fullname, gender, dob, country, address, zipcode) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, userId);
                preparedStatement.setString(2, fullName);
                preparedStatement.setString(3, gender);
                preparedStatement.setString(4, dob);
                preparedStatement.setString(5, country);
                preparedStatement.setString(6, address);
                preparedStatement.setString(7, zipcode);

                int rowsInserted = preparedStatement.executeUpdate();

                preparedStatement.close();
                connection.close();

                if (rowsInserted > 0) {
                    // Insertion successful
                    String successMessage = "Account Added Successfully!";
                    response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'account_settings.jsp';</script>");
                } else {
                    // Handle insertion failure
                    String invalidMessage = "Account Addition Failed!";
                    response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'account_settings.jsp';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
        } else if ("password".equals(action)) {
            // Handle password change logic here
            // ...
        } else if ("deleteAccount".equals(action)) {
            // Handle account deletion logic here
            // ...
        }
    }

    
    

    private boolean isPreviousPasswordValid(int userId, String prevPassword) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();
            String sql = "SELECT password FROM users WHERE id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String storedPasswordHash = resultSet.getString("password");
                
                // Use BCrypt to verify the password
                if (storedPasswordHash.equals(prevPassword)) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database query errors
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle closing database resources errors
            }
        }

        return false;
    }
}
