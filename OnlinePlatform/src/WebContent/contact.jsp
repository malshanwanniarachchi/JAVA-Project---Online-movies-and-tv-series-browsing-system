<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Support</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" type="text/css" href="css/contact.css">
    <script src="js/main.js"></script>
</head>
<body>
    <div id="header">
        <!-- You can include dynamic content here if needed -->
    </div>
    <form action="Contact" method="POST">
        <div class="container">
            <center><h2>Contact Us</h2></center><br>
            <label for="uname" for="psw"><a class="a1"><b>Name</b></a></label>
            <input type="text" placeholder="Enter Name" name="name" required>

            <label for="uname"><a class="a1"><b>Email</b></a></label>
            <input type="text" placeholder="Enter Email" name="email" required>

            <label for="uname"><a class="a1"><b>Phone Number</b></a></label>
            <input type="text" placeholder="Enter Phone Number" name="phone" maxlength="10" required>

            <label for="uname"><a class="a1"><b>Messages</b></a></label><br><textarea id="msg" name="msg" rows="6" cols="68" required></textarea><br><br>
            <button class="btn btn-1" type="Submit" name="submit" onclick="return validateContactUs()">Submit</button>

            <label>
            </label>
        </div>
    </form>
    <br>
</body>

<div id="footer"></div>

</html>
<!-- End Footer -->
