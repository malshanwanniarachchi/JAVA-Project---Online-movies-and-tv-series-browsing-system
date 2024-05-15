package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Deletecontent")
public class Deletecontent extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    Connection connection = null;

	    try {
	        connection = DBConnection.getConnection();

	        // Handle content deletion logic here
	        int contentId = Integer.parseInt(request.getParameter("delete"));

	        // Delete the content with the specified contentId from the database
	        String sql = "DELETE FROM app WHERE id = ?";
	        PreparedStatement preparedStatement = connection.prepareStatement(sql);
	        preparedStatement.setInt(1, contentId);

	        int rowsDeleted = preparedStatement.executeUpdate();

	        preparedStatement.close();

	        if (rowsDeleted > 0) {
	            // Deletion was successful
	        	String successMessage = "Content Deleted Successfully!";
	        	response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'uploader.jsp#settings';</script>");
	        } else {
	            // Content not found or deletion failed
	        	String failMessage = "Deletion Failed";
	        	response.getWriter().println("<script>alert('" + failMessage + "'); window.location = 'uploader.jsp#settings';</script>");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Handle database connection or query errors
	        response.sendRedirect("uploader.jsp?error=database_error");
	    } finally {
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
