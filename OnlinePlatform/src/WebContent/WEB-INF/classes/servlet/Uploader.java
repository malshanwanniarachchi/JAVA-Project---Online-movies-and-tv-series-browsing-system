package servlet;

import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
   

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");
    	
    	 HttpSession session = request.getSession();
    	 int userId = (int) session.getAttribute("id");
    	
    	
    	Connection connection = null;

    if ("a".equals(action)) { 
        
        try {
            connection = DBConnection.getConnection();

            // Retrieve and process form data
           
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String bankAccount = request.getParameter("bank_account");
            String paypalId = request.getParameter("paypal_id");
            String contactNumber = request.getParameter("contact_number");
            String address = request.getParameter("address");
            String country = request.getParameter("country");

            
                // Handle add developer settings logic here
                String insertSql = "INSERT INTO developer_settings (name, email, bank_account, paypal_id, contact_number, address, country, userid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertSql);
                insertStatement.setString(1, name);
                insertStatement.setString(2, email);
                insertStatement.setString(3, bankAccount);
                insertStatement.setString(4, paypalId);
                insertStatement.setString(5, contactNumber);
                insertStatement.setString(6, address);
                insertStatement.setString(7, country);
                insertStatement.setInt(8, userId);

                int rowsInserted = insertStatement.executeUpdate();
                insertStatement.close();
                connection.close();

                if (rowsInserted > 0) {
                    // Add successful
                    String successMessage = "Developer Settings Added Successfully!";
                    response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'uploader.jsp#settings';</script>");
                } else {
                    // Add failed
                    String errorMessage = "Developer Settings Addition Failed!";
                    response.getWriter().println("<script>alert('" + errorMessage + "'); window.location = 'uploader.jsp#settings';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
       
    	 }
    	 
    	 
    	 else if ("u".equals(action)) {
    		 
    		 try {
                 connection = DBConnection.getConnection();
                 
                 
                 String name = request.getParameter("name");
                 String email = request.getParameter("email");
                 String bankAccount = request.getParameter("bank_account");
                 String paypalId = request.getParameter("paypal_id");
                 String contactNumber = request.getParameter("contact_number");
                 String address = request.getParameter("address");
                 String country = request.getParameter("country");
            	
                // Handle update developer settings logic here
                String updateSql = "UPDATE developer_settings SET name=?, email=?, bank_account=?, paypal_id=?, contact_number=?, address=?, country=? WHERE userid=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateSql);
                updateStatement.setString(1, name);
                updateStatement.setString(2, email);
                updateStatement.setString(2, bankAccount);
                updateStatement.setString(4, paypalId);
                updateStatement.setString(5, contactNumber);
                updateStatement.setString(6, address);
                updateStatement.setString(7, country);
                updateStatement.setInt(8, userId);

                int rowsUpdated = updateStatement.executeUpdate();
                updateStatement.close();
                connection.close();

                if (rowsUpdated > 0) {
                    // Update successful
                    String successMessage = "Developer Settings Updated Successfully!";
                    response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'uploader.jsp#settings';</script>");
                } else {
                    // Update failed
                    String errorMessage = "Developer Settings Update Failed!";
                    response.getWriter().println("<script>alert('" + errorMessage + "'); window.location = 'uploader.jsp#settings';</script>");
                }
            }
    		 catch (SQLException e) {
    	            e.printStackTrace();
    	            // Handle database connection or query errors
    	       }
    		 
    		  finally {
    	            try {
    	                if (connection != null) {
    	                    connection.close();
    	                }
    	            } catch (SQLException e) {
    	                e.printStackTrace();
    	                // Handle closing database resources errors
    	            }
    	        }
          } 
  
    }
}
