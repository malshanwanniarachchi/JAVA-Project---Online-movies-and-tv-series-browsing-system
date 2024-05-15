package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AccData")
public class AccData extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    	HttpSession session = request.getSession();

        // Retrieve user's session ID
        int userId = (int) session.getAttribute("id");
        
        
        Connection connection = null;
      //  PreparedStatement preparedStatement = null;
        ResultSet userDataResult = null;
        Statement statement = null;

        try {
            connection = DBConnection.getConnection();
            String userDataQuery = "SELECT * FROM account_details WHERE id = " + userId;
            statement = connection.createStatement();
            //preparedStatement = connection.prepareStatement(userDataQuery);
           // preparedStatement.setInt(1, userId);

            // Fetch user data from the database based on the user ID
            
            userDataResult = statement.executeQuery(userDataQuery);
            
           
            
            while (userDataResult.next()) {
                // Retrieve user data from the database
                String fullname = userDataResult.getString("fullname");
                String gender = userDataResult.getString("gender");
                String dob = userDataResult.getString("dob");
                String country = userDataResult.getString("country");
                String address = userDataResult.getString("address");
                String zipcode = userDataResult.getString("zipcode");
                String image = userDataResult.getString("image");
                
             // Set user data in session
                request.setAttribute("fullname", fullname);
                request.setAttribute("gender", gender);
                request.setAttribute("dob", dob);
                request.setAttribute("country", country);
                request.setAttribute("address", address);
                request.setAttribute("zipcode", zipcode);
                request.setAttribute("image", image);
                

                // Fetch card data from the database
                String cardDataQuery = "SELECT * FROM card WHERE id = " + userId;
                statement = connection.createStatement();
                //preparedStatement = connection.prepareStatement(cardDataQuery);
               // preparedStatement.setInt(1, userId);
                
                ResultSet cardDataResult =statement.executeQuery(cardDataQuery);

                while (cardDataResult.next()) {
                    String cardno = cardDataResult.getString("cardno");
                    String name = cardDataResult.getString("name");
                    String expire = cardDataResult.getString("expire");

                 // Set card data in session
                    
                    request.setAttribute("cardno", cardno);
                    request.setAttribute("name", name);
                    request.setAttribute("expire", expire);
                }
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward the request to the JSP
        request.getRequestDispatcher("myaccount.jsp").forward(request, response);
    }
}
