package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/Uploadcontent")
@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15, // 15 MB
        location            = "D:/Java/EE/OnlinePlatform/src/WebContent/img"
)
public class Uploadcontent extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");

        try {
            connection = DBConnection.getConnection();
            if (connection != null) {
            // Retrieve and process form data
            String appName = request.getParameter("appname");
            String category = request.getParameter("category");
            String description = request.getParameter("des");
            String type = request.getParameter("type");
            String mtype = request.getParameter("mtype");
            double price = 0.00;

            // Handle file upload for Content Thumbnail (apppic)
            Part apppicPart = request.getPart("apppic");
            String apppicFileName = apppicPart.getSubmittedFileName();
            String uploadPath = "D:/Java/EE/OnlinePlatform/src/WebContent/img"; // Set the directory where you want to save uploaded files
            String apppicFilePath =  apppicFileName;
            
            try (InputStream fileContent = apppicPart.getInputStream()) {
                // Save the uploaded file to the specified directory
                // You may need to create the directory if it doesn't exist
                File uploadDirectory = new File(uploadPath);
                if (!uploadDirectory.exists()) {
                    uploadDirectory.mkdirs();
                }
                Files.copy(fileContent, Paths.get("D:/Java/EE/OnlinePlatform/src/WebContent/img/" + apppicFileName));
            }
            
            // Insert the data into the database
            String sql = "INSERT INTO app (name, category, description, type, mtype, price, image, userid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, appName);
            preparedStatement.setString(2, category);
            preparedStatement.setString(3, description);
            preparedStatement.setString(4, type);
            preparedStatement.setString(5, mtype);
            preparedStatement.setDouble(6, price);
            preparedStatement.setString(7, apppicFilePath); // Store the file path in the database
            preparedStatement.setInt(8, userId);
            int rowsInserted = preparedStatement.executeUpdate();
            
            
            
            if (rowsInserted > 0) {
                // Registration was successful
            	 String successMessage = "Upload Successful!";
                 response.getWriter().println("<script>alert('" + successMessage + "'); window.location = 'home.jsp';</script>");
            } else {
                // Registration failed
            	String invalidMessage = "Upload Failed!";
                response.getWriter().println("<script>alert('" + invalidMessage + "'); window.location = 'Signup.jsp';</script>");
            }

            preparedStatement.close();
            }
          else {
	            // Handle the case where the database connection couldn't be established // Handle the case where the database connection couldn't be established
	    	  	response.getWriter().println("Failed to connect to the database.");
	        }
            
            
        } catch (SQLException e) {
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

        // Redirect back to the dashboard
        response.sendRedirect("uploader.jsp");
    }
}
