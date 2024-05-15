<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, servlet.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>TV Shows</title>
  <link rel="stylesheet" href="css/home.css">
  <script src="js/main.js"></script>
  
</head>


<div id="header"></div>
 
<body>
  <div class="header-section">
    <h1>Welcome to Beestream</h1>
    <p>The best place to watch TV Shows</p>
    <div class="search-bar">
      <input type="text" placeholder="Search here...">
      <button type="submit">Search</button>
    </div>
  </div>
  
  <section id="top-charts">
    <h3 class="section-title">Top Charts</h3>
    <ul class="tab-navigation">
      <li><a href="#top-free" class="tab-button">Top Free</a></li>
      <li><a href="#top-trending" class="tab-button">Top Trending</a></li>
      <li><a href="#top-paid" class="tab-button">Top Paid</a></li>
    </ul>
    
    <div class="carousel-container">
	    <div class="carousel-arrow left-arrow top-charts">&lt;</div>
	    <div class="carousel-arrow right-arrow top-charts">&gt;</div>
	    <div id="top-free" class="carousel">
	      <%
	      
	        // JSP code to retrieve and display data from the database
	        try {
	          Connection connection = DBConnection.getConnection();
	          Statement statement = connection.createStatement();
	          String sql = "SELECT * FROM app  WHERE mtype = 'show' ORDER BY id ASC";
	          ResultSet result = statement.executeQuery(sql);
	          while (result.next()) {
	      %>
	            <div class="app-card">
	              <img src="<%= "img/" + result.getString("image") %>" alt="App 1">
	              <h4><%= result.getString("name") %></h4>
	              <p><%= result.getString("category") %></p>
	              <a href="#" class="button">Watch</a>
	            </div>
	      <%
	          }
	          connection.close();
	        } catch (SQLException e) {
	          e.printStackTrace();
	        }
	      %>
	    </div>
	    <div id="top-trending" class="carousel">
	      <%
	      
	        // JSP code to retrieve and display data from the database
	        try {
	          Connection connection = DBConnection.getConnection();
	          Statement statement = connection.createStatement();
	          String sql = "SELECT * FROM app WHERE mtype = 'show' ORDER BY id DESC";
	          ResultSet result = statement.executeQuery(sql);
	          while (result.next()) {
	      %>
	            <div class="app-card">
	              <img src="<%= "img/" + result.getString("image") %>" alt="App 1">
	              <h4><%= result.getString("name") %></h4>
	              <p><%= result.getString("category") %></p>
	              <a href="#" class="button">Watch</a>
	            </div>
	      <%
	          }
	          connection.close();
	        } catch (SQLException e) {
	          e.printStackTrace();
	        }
	      %>
	    </div>
	    <div id="top-paid" class="carousel">
	      <%
	      
	        // JSP code to retrieve and display data from the database
	        try {
	          Connection connection = DBConnection.getConnection();
	          Statement statement = connection.createStatement();
	          String sql = "SELECT * FROM app WHERE mtype = 'show'  ORDER BY Name ASC";
	          ResultSet result = statement.executeQuery(sql);
	          while (result.next()) {
	      %>
	            <div class="app-card">
	              <img src="<%= "img/" + result.getString("image") %>" alt="App 1">
	              <h4><%= result.getString("name") %></h4>
	              <p><%= result.getString("category") %></p>
	              <a href="#" class="button">Watch</a>
	            </div>
	      <%
	          }
	          connection.close();
	        } catch (SQLException e) {
	          e.printStackTrace();
	        }
	      %>
	    </div>
  </div>
  </section>
  
  <section id="top-rated">
    <h3 class="section-title">Top Rated</h3>
    
    <div class="carousel-container">
	    
	    <div class="carousel-arrow left-arrow top-rated">&lt;</div>
	    <div class="carousel-arrow right-arrow top-rated">&gt;</div>
	    <div id="top-rated-carousel" class="carousel">
	    
	      <%
	      
	        // JSP code to retrieve and display data from the database
	        try {
	          Connection connection = DBConnection.getConnection();
	          Statement statement = connection.createStatement();
	          String sql = "SELECT * FROM app WHERE mtype = 'show'  ORDER BY id ASC";
	          ResultSet result = statement.executeQuery(sql);
	          while (result.next()) {
	      %>
	            <div class="app-card">
	              <img src="<%= "img/" + result.getString("image") %>" alt="App 1">
	              <h4><%= result.getString("name") %></h4>
	              <p><%= result.getString("category") %></p>
	              <a href="#" class="button">Watch</a>
	            </div>
	      <%
	          }
	          connection.close();
	        } catch (SQLException e) {
	          e.printStackTrace();
	        }
	      %>
	    </div>
    </div>
  </section>
  <script src="js/carousel.js"></script>
  
</body>

<div id="footer"></div>


</html>
