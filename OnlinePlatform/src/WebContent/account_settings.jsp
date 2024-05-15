<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, java.sql.SQLException, servlet.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Account</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" type="text/css" href="css/accountsettings.css">
    <link rel="stylesheet" type="text/css" href="css/appearance.css">
    <link rel="stylesheet" type="text/css" href="css/passwordPage.css">
    <script src="js/main.js"></script>
    <script src="js/acc_settings.js"></script>
</head>
<div id="header"></div>
<body>

<% 
int userId = (int) session.getAttribute("id");
String fullname = null;
String gender = null;
String dob = null;
String country = null;
String address = null;
String zipcode = null;

// JSP code to retrieve card data from the database
try {
    Connection connection = DBConnection.getConnection();
    Statement statement = connection.createStatement();
    String sql = "SELECT * FROM account_details WHERE userid =" + userId;
    ResultSet result = statement.executeQuery(sql);

    if (result.next()) {
        fullname = result.getString("fullname");
        gender = result.getString("gender");
        dob = result.getString("dob");
        country = result.getString("country");
        address = result.getString("address");
        zipcode = result.getString("zipcode");
    }

    connection.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

    <div class="sttHeader">
        <center>
            <font style="color: white;" size="5px"><b>Settings</b></font><br>
            <font style="color: white;">Manage Your Settings</font>
        </center>
    </div>
    <div class="row">
        <!-- Your HTML content -->
        <div class="left" style="background-color:#f0f0f0;">
            <ul id="myMenu">
                <li><a href="#" onclick="showAccountSettings()">Account Settings</a></li>
                <li><a href="#" onclick="displayPassword()">Password</a></li>
            </ul>
        </div>
        <div class="right" style="background-color:#f0f0f0;">
            <!-- Account settings form -->
            <div id="accountSettings" class="section">
                <center>
                    <h2>Account Settings</h2>
                </center>
                <hr class="new1">
                <form method="POST" action="AccountSettings" name="action" value="update">
                    <!-- Input fields for updating user information -->
                    <input type="hidden" name="action" value="<%= (fullname == null) ? 'a' : 'u' %>">
                    <label for="profilePic">Profile Picture:</label>
                    <input type="file" name="file" id="profilePic" accept="image/jpg, image/png, image/jpeg">
                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullname" value="<%=fullname%>">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" value="<%=gender%>">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%=session.getAttribute("email")%>" disabled>
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" value="<%=dob%>">
                    <label for="country">Country:</label>
                    <input type="text" id="country" name="country" value="<%=country%>">
                    <label for="address">Address:</label>
                    <textarea id="address" name="address"><%=address%></textarea>
                    <label for="zipCode">Zip Code:</label>
                    <input type="text" id="zipCode" name="zipcode" maxlength="5" value="<%=zipcode%>">
                    <button type="submit" name="update">Update</button>
                </form>

                <!-- Account Delete button -->
                <form method="POST" action="AccountSettings" name="action" value="deleteAccount">
                    <input type="hidden" name="action" value="deleteAccount">
                    <button type="submit" name="deleteAccount" onclick="return confirm('Are you sure you want to delete your account?')">Delete Account</button>
                </form>
            </div>
            <!-- Password change form -->
            <div id="passwordSettings" class="section">
                <h1>Password Page</h1>
                <form method="POST" action="AccountSettings" name="action" value="password">
                    <!-- Input fields for changing the password -->
                    <input type="hidden" name="action" value="password">
                    <label for="prevPassword">Previous Password:</label>
                    <input type="password" id="prevPassword" name="prevPassword">
                    <label for="newPassword">New Password:</label>
                    <input type="password" id="newPassword" name="newPassword">
                    <label for="confirmPassword">Confirm New Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                    <button type="submit" name="password" onclick="return changePassword()">Change Password</button>
                </form>
            </div>
        </div>
    </div>
   </body>

<div id="footer"></div>
</html>
