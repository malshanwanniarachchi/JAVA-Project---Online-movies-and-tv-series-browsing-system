package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogOut")
public class LogOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get the session, or create a new one if it doesn't exist

        if (session != null) {
            session.invalidate(); // Invalidate the session (log out)
        }

        // Redirect to the login page after logout
        response.sendRedirect("login.jsp"); // Change "login.jsp" to the appropriate page
    }
}
