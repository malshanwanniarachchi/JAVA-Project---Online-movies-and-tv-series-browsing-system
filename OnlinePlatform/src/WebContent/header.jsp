<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>


<!DOCTYPE html>
<html>


    <header>
        <div class="logo">
            <a href="home.jsp"><img src="img/Logo.png" alt="Logo"></a>
        </div>
        <nav>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="movies.jsp">Movies</a></li>
                <li><a href="shows.jsp">TV Shows</a></li>
                <c:if test="${not empty sessionScope.id}">
                    <li><a href="uploader.jsp">Dashboard</a></li>
                </c:if>
                <li><a href="doc.jsp">Docs</a></li>
            </ul>
        </nav>
        <div class="buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.id}">
                    <a href="myaccount.jsp" class="signup-button">${sessionScope.firstname}</a>
                    <a href="LogOut" class="login-button">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="signup.jsp" class="signup-button">Sign Up</a>
                    <a href="login.jsp" class="login-button">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

</html>
