package servlet;

import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/Card")
public class Card extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Database connection setup (you should use a connection pool)
        Connection connection = null;
        

        try {
            String action = request.getParameter("action");
            connection = DBConnection.getConnection();

            if ("edit".equals(action)) {
                // Update card details
                String cardNumber = request.getParameter("cardno");
                String cardName = request.getParameter("cardname");
                String expireDate = request.getParameter("expire");
                String cvv = request.getParameter("cvv");
                int userId = (int) session.getAttribute("id");

                String updateQuery = "UPDATE card SET cardno=?, name=?, expire=?, cvv=? WHERE userid=?";
                PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                updateStatement.setString(1, cardNumber);
                updateStatement.setString(2, cardName);
                updateStatement.setString(3, expireDate);
                updateStatement.setString(4, cvv);
                updateStatement.setInt(5, userId);

                int rowsUpdated = updateStatement.executeUpdate();
                if (rowsUpdated > 0) {
                	response.getWriter().write("<script>alert('Card Successfully Updated'); window.location.href='payment.jsp';</script>");

                } else {
                	response.getWriter().write("<script>alert('SQL Error!'); window.location.href='payment.jsp';</script>");
                }
            } else if ("add".equals(action)) {
                // Insert new card
                String cardNumber = request.getParameter("cardno");
                String cardName = request.getParameter("cardname");
                String expireDate = request.getParameter("expire");
                String cvv = request.getParameter("cvv");
                int userId = (int) session.getAttribute("id");

                String insertQuery = "INSERT INTO card (cardno, name, expire, cvv, userid) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
                insertStatement.setString(1, cardNumber);
                insertStatement.setString(2, cardName);
                insertStatement.setString(3, expireDate);
                insertStatement.setString(4, cvv);
                insertStatement.setInt(5, userId);

                int rowsInserted = insertStatement.executeUpdate();
                if (rowsInserted > 0) {
                	response.getWriter().write("<script>alert('Card Successfully Added'); window.location.href='payment.jsp';</script>");
                } else {
                	response.getWriter().write("<script>alert('SQL Error!'); window.location.href='payment.jsp';</script>");
                }
            } else if ("deleteCard".equals(action)) {
                int userId = (int) session.getAttribute("id");

                String deleteQuery = "DELETE FROM card WHERE userid=?";
                PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
                deleteStatement.setInt(1, userId);

                int rowsDeleted = deleteStatement.executeUpdate();
                if (rowsDeleted > 0) {
                	response.getWriter().write("<script>alert('Card Successfully Deleted'); window.location.href='payment.jsp';</script>");
                } else {
                	response.getWriter().write("<script>alert('SQL Error!'); window.location.href='payment.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('SQL Error!'); window.location.href='payment.jsp';</script>");
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    
    
}
