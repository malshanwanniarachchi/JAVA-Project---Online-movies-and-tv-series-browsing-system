<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, servlet.DBConnection, java.text.SimpleDateFormat, java.util.Calendar, java.util.Date" %>

<%
int userId = (int) session.getAttribute("id");

Connection connection = null;
Statement statement = null;
ResultSet result = null;
String image = "";
String firstName = "";
String email = "";
String dob = "";
int age = 0;
String gender = "";
String fullname = "";
String country = "";
String address = "";
String zipcode = "";

try {
    connection = DBConnection.getConnection();
    statement = connection.createStatement();
    String sql = "SELECT * FROM account_details WHERE userid =" + userId;
    result = statement.executeQuery(sql);

    if (result.next()) {
        image = result.getString("image");

        firstName = (String) session.getAttribute("firstname");
        email = (String) session.getAttribute("email");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date currentDate = new Date();
        Date birthDate = dateFormat.parse(result.getString("dob"));

        Calendar currentCalendar = Calendar.getInstance();
        currentCalendar.setTime(currentDate);

        Calendar birthCalendar = Calendar.getInstance();
        birthCalendar.setTime(birthDate);

        age = currentCalendar.get(Calendar.YEAR) - birthCalendar.get(Calendar.YEAR);

        // Check if the birthday hasn't occurred this year yet
        if (currentCalendar.get(Calendar.DAY_OF_YEAR) < birthCalendar.get(Calendar.DAY_OF_YEAR)) {
            age--;
        }

        gender = (result.getString("gender") != null && !result.getString("gender").isEmpty()) ? result.getString("gender") : "NOT SET";

        fullname = (result.getString("fullname") != null && !result.getString("fullname").isEmpty()) ? result.getString("fullname") : "NOT SET";
        dob = (result.getString("dob") != null && !result.getString("dob").isEmpty()) ? result.getString("dob") : "NOT SET";
        country = (result.getString("country") != null && !result.getString("country").isEmpty()) ? result.getString("country") : "NOT SET";
        address = (result.getString("address") != null && !result.getString("address").isEmpty()) ? result.getString("address") : "NOT SET";
        zipcode = (result.getString("zipcode") != null && !result.getString("zipcode").isEmpty()) ? result.getString("zipcode") : "NOT SET";
    }
} catch (SQLException e) {
    e.printStackTrace();
} finally {
    if (result != null) {
        try {
            result.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (statement != null) {
        try {
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>My Account</title>
    <link rel="stylesheet" href="css/my_account.css">
    <link rel="stylesheet" href="css/home.css">
    <script src="js/main.js"></script>
</head>
<div id="header"></div>
<body>

    
    <div class="accHeader">
        <center>
            <font size="5px"><b>Account Details</b></font>
        </center>
    </div>
    <div class="row">
        <div class="left" style="background-color:#bbb;">
            <center>
              <img src="<%= (image != null && !image.isEmpty()) ? "uploads/" + java.net.URLEncoder.encode(image, "UTF-8") : "uploads/image.jpg" %>" height="200px" width="200px" alt="Profile Picture" class="logo"><br>
                <font size="5px"><%= session.getAttribute("firstname") %></font><br>
                <%= session.getAttribute("email") %>
            </center>
            <hr class="new1">
            &nbsp;&nbsp;
            <font size="3px"><b>General</b></font>
            <hr>
            &nbsp;&nbsp;Nick Name: <%= session.getAttribute("firstname") %><br>
            &nbsp;&nbsp;Age: <%= age%><br>
            &nbsp;&nbsp;Gender: <%= gender %>
            <br><br>
            <hr>
            <b>Subscriptions</b>

            <ul id="myMenu">
                <li><a href="#"></a></li>
            </ul>
        </div>
      
        <div class="right" style="background-color:#ddd;">
            <ul id="nav" class="nav">
                <li><a href="myaccount.jsp">Account Details</a></li>
                <li><a href="payment.jsp">Payment Details</a></li>
                <li><a href="account_settings.jsp">Settings</a></li>
            </ul>
            <hr class="new1">
            <h2 style="padding:1px 1px;">Bio</h2>
            <hr class="new1">
            Full Name: <%= fullname %><br>
            Gender: <%= gender %><br>
            E-mail: <%= (email != null) ? session.getAttribute("email") : "NOT SET" %><br>
            Date of Birth: <%= (dob != null && !dob.isEmpty()) ? dob : "NOT SET" %><br>
            Country: <%= country %><br>
            Address: <%= address %><br>
            Zip Code: <%= zipcode %><br>

            <hr class="new1">
            <h2 style="padding:1px 1px;">Payment Details</h2>
            <hr class="new1">
        
   
    <%

   String nameOnCard = "NOT SET";
   String formattedCardno = "NOT SET";
   String expireDate = "NOT SET";
   String paymentMethod = "NOT SET";

   // JSP code to retrieve and display data from the database
   try {
        connection = DBConnection.getConnection();
        statement = connection.createStatement();
        String sql = "SELECT * FROM card WHERE userid = " + userId;
        result = statement.executeQuery(sql);
       
       if (result.next()) {
           nameOnCard = (result.getString("name") != null && !result.getString("name").isEmpty()) ? result.getString("name") : "NOT SET";
           
           String cardno = result.getString("cardno");
           formattedCardno = (!cardno.isEmpty()) ? cardno.replaceAll("(.{4})", "$1 ") : "Not set";
           
           expireDate = (result.getString("expire") != null && !result.getString("expire").isEmpty()) ? result.getString("expire") : "NOT SET";
           
           paymentMethod = (!cardno.isEmpty()) ? "Credit Card" : "Not set";
       }
       
       connection.close();
   } catch (SQLException e) {
       e.printStackTrace();
   }
   %>

   Name on Card: <%= nameOnCard %><br>
   Card Number: <%= formattedCardno %><br>
   Expire Date: <%= expireDate %><br>
   Payment Method: <%= paymentMethod %><br>
   </div>
   </div>

</body>

<div id="footer"></div>


</html>
