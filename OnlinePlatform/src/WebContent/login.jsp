<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <script src="js/main.js"></script>
    </head>
    <body>
        <div id="header"></div>
        <br>
        <form action="LogIn" method="POST">
            <div class="container">
                <center>
                    <h2>Login</h2>
                </center><br>
                <label for="uname"><a class="a1"><b>Username</b></a></label>
                <input type="text" placeholder="Enter Username" name="username" required>
                <label for="lable" for="psw"><a class="a1"><b>Password</b></a></label>
                <input type="password" placeholder="Enter Password" name="password" required>
                <label>
                    <center> <input type="checkbox" checked="checked" name="remember"><a class="a2">Save Password</a></center><br>
                    <button type="submit" value="submit" class="btn btn-1" name="btnSubmit"><b>Login</b></button><br><br>
                    <center><a href="#" class="a3"><b>Forgot Password?</b></a></center>
                </label>
            </div>
        </form>
        <br>
  
</body>

<div id="footer"></div>


</html>
