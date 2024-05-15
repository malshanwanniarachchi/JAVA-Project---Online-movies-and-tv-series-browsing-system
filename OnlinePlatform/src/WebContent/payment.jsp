<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, servlet.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Payment</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" type="text/css" href="css/payment.css">
    <script src="js/main.js"></script>
    <script src="js/card.js"></script>
</head>
<div id="header"></div>
<body>
    <% int userId = (int) session.getAttribute("id");
String cardno = null;
String cardname = null;
String expire = null;
String cvv = null;
boolean saveCard = false;

// JSP code to retrieve card data from the database
try {
    Connection connection = DBConnection.getConnection();
    Statement statement = connection.createStatement();
    String sql = "SELECT * FROM card WHERE userid =" + userId;
    ResultSet result = statement.executeQuery(sql);

    if (result.next()) {
        cardno = result.getString("cardno");
        cardname = result.getString("name");
        expire = result.getString("expire");
        cvv = result.getString("cvv");
        saveCard = true;
    }

    connection.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

<form method="POST" action="Card">
    <div class="container">
        <center>
            <h2>Card Details</h2>
        </center>
        <br>
        <h1 style="color: rgb(118, 70, 11);">Edit card details</h1>
        <div class="payment">
            <div class="row">
                <img class="img" src="img/payment2.png" alt="">
                <img class="img" src="img/payment3.png" alt="">
                <img class="img" src="img/payment1.webp" alt="">
                <img class="img" src="img/payment4.jpg">
            </div>

            <label for="cnum"><a class="a1"><b>Card number</b></a></label>
            <input type="text" placeholder="Enter card number" name="cardno" id="cardno" maxlength="16"
                value="<%= cardno %>" required>

            <label for="cname"><a class="a1"><b>Name on card</b></a></label>
            <input type="text" placeholder="Enter card name" name="cardname"
                value="<%= cardname %>" required>

            <label for="date"><a class="a1"><b>Expiration date</b></a></label><br>
            <input type="date" placeholder="Enter date of expiration" name="expire"
                value="<%= expire %>" required><br><br>

            <label for="skey"><a class="a1"><b>CVV</b></a></label>
            <input type="text" placeholder="Enter cvv number" name="cvv" id="cvv" maxlength="3"
                value="<%= cvv %>" required>
            <label>
            <center>
                <input type="checkbox" name="save" <%= saveCard ? "checked" : "" %>><a class="a2">Save this card</a>
            </center><br>
            <div class="pcard">
                    
                    	<%
                       
                        if (cardno != null) {
                        %>
                            <button type="submit" class="card card-1" name="action" value="edit" onclick="return validateCard();"><b>Edit card</b></button><br><br>
                            <button type="submit" class="card2 card-2" name="action" value="deleteCard" onclick="return confirm('Are you sure you want to delete')"><b>Delete card</b></button><br><br>
                        
                        <%
                        } else {
                        %>
                            <button type="submit" class="card card-1" name="action" value="add" onclick="return validateCard();"><b>Add card</b></button>
                            
                        <%
                        }
                        
                        %>
                    
                    
                    
                </div>
            </label>
        </div>
    </div>
</form>
 <div id="confirmationDialog" class="modal">
        <div class="modal-content">
            <h3>Confirm Deletion</h3>
            <p>Are you sure you want to delete?</p>
            <div class="button-container">
                <button id="confirmDeleteButton" onclick="deleteCard()">Delete</button>
                <button onclick="closeConfirmationDialog()">Cancel</button>
            </div>
        </div>
    </div>
</body>

<div id="footer"></div>


</html>