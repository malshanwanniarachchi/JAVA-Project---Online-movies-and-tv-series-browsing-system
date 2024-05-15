package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import servlet.DBConnection; // Import your database connection class

@WebServlet("/UpdateStatus")
public class UpdateStatus extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inquiryId = request.getParameter("id");
        String newStatus = request.getParameter("status");

        if (inquiryId != null && newStatus != null) {
            try {
                // Establish a database connection
                Connection connection = DBConnection.getConnection(); // Replace with your database connection method

                // Define the SQL query to update the status
                String updateQuery = "UPDATE contactus SET status = ? WHERE id = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
                preparedStatement.setString(1, newStatus);
                preparedStatement.setString(2, inquiryId);

                // Execute the query to update the status
                int rowsAffected = preparedStatement.executeUpdate();

                // Close the database connection
                connection.close();

                if (rowsAffected > 0) {
                	String successMessage = "Updated Successfully!";
                    response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'uploader.jsp#inquiries';</script>");
                } else {
                	 String errorMessage = "Update Failed!";
                     response.getWriter().println("<script>alert('" + errorMessage + "'); window.location = 'uploader.jsp#inquiries';</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                String errorMessage = "SQL Error!";
                response.getWriter().println("<script>alert('" + errorMessage + "'); window.location = 'uploader.jsp#settings';</script>");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        }
    }
}

