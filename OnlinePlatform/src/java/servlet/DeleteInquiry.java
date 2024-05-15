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

@WebServlet("/DeleteInquiry")
public class DeleteInquiry extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inquiryId = request.getParameter("delete");
        if (inquiryId != null) {
            try {
                // Establish a database connection
                Connection connection = DBConnection.getConnection(); // Replace with your database connection method

                // Define the SQL query to delete the inquiry
                String deleteQuery = "DELETE FROM contactus WHERE id = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setString(1, inquiryId);

                // Execute the query to delete the inquiry
                int rowsAffected = preparedStatement.executeUpdate();

                // Close the database connection
                connection.close();

                if (rowsAffected > 0) {
                    // Deletion was successful
                    response.sendRedirect("uploader.jsp#inquiries"); // Redirect to the inquiries page or a suitable page
                } else {
                    // Deletion failed
                    String errorMessage = "Failed to delete the inquiry. Please try again.";
                    request.setAttribute("error", errorMessage);
                    request.getRequestDispatcher("uploader.jsp#inquiries").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle any database-related exceptions
                String errorMessage = "An error occurred while processing your request. Please try again later.";
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("uploader.jsp#inquiries").forward(request, response);
            }
        }
    }
}
