<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" type="text/css" href="css/signup.css">
    <script src="js/main.js"></script>
    <script src="js/signup.js"></script>
</head>
<body>
    <div id="header"></div>

    <div class="container">
        <center><h2>Create an Account</h2></center><br>
        <form action="SignUp" method="POST">
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" placeholder="Enter First Name" name="firstName" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" placeholder="Enter Last Name" name="lastName" required>
                </div>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" placeholder="Enter Email" name="email" required>
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" placeholder="Enter Username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" placeholder="Enter Password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" placeholder="Confirm Password" id="confirmpassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                <label for="agreeTerms">I agree with the user terms and privacy policies</label>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-1" name="btnSubmit" value="Submit" onclick="return validateSignup()"><b>Sign Up</b></button>
            </div>
        </form>
    </div>

</body>

<div id="footer"></div>


</html>
