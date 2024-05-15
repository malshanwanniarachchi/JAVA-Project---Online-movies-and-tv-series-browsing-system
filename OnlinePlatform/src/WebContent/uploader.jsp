<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, java.sql.SQLException, servlet.DBConnection" %>
<%@ page import="java.sql.PreparedStatement" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Content Provider</title>
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/settings.css">
    <link rel="stylesheet" href="css/uploader.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <script src="js/main.js"></script>
    
</head>

<div id="header"></div>
<body>
    <div class="dashboard-container">
        <div class="user-info-container">
            <div class="user-info-box">
                <div class="user-avatar">
                    <img src="img/davatar.png" alt="User Avatar" style="max-width: 150px; max-height: 150px;">
                </div>
                <div class="user-info">
                    <h2 class="user-username"><%= session.getAttribute("username") %></h2>
                    <p class="user-member-since">Member since <%= session.getAttribute("jdate") %></p>
                </div>
            </div>

            <div class="tab-menu-container">
                <div class="tab-menu">
                    <ul>
                        <li><a href="#dashboard" class="active">Dashboard</a></li>
                        <li><a href="#my-projects">My Uploads</a></li>
                        <li><a href="#activity">Activity</a></li>
                       <%-- Check if the user is an admin and show the "Inquiries" tab if they are --%>
        <% // Check if the user is an admin
        boolean isAdmin = false;
        if (session.getAttribute("isAdmin") != null) {
            isAdmin = (boolean) session.getAttribute("isAdmin");
        }
        
        if (isAdmin) { %>
            
              
                    <li><a href="#inquiries">Inquiries</a></li>
               
        <% } %> 
                        <li><a href="#payment">Payment</a></li>
                        <li><a href="#settings">Settings</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="content-area-container">
            <div class="content-area">
                <div id="dashboard" class="tab-content active">
                    <!-- Content for the Dashboard tab -->
                    <h2>Upload Content</h2>
                    <form action="Uploadcontent" method="POST"  enctype="multipart/form-data">
                        <label for="apppic">Content Thumbnail</label>
                        <input type="file" name="apppic" id="apppic"><br><br>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="appname">Content Name</label>
                                <input type="text" name="appname" required>
                            </div>

                            <div class="form-group">
                                <label for="category">Category</label>
                                <input type="text" id="category" name="category" required>
                            </div>
                        </div>

                        <label for="des">Description</label>
                        <input type="text" name="des" required>
                        <div class="form-row">
                            <div class="form-group">
                               <label for="type">Purchase Type:</label>
			                        <select name="type" id="type" required onchange="handleTypeChange()">
			                            <option value="">Select Type</option>
			                            <option value="Free">Free</option>
			                            <option value="Paid">Paid</option>
			                        </select>
                            </div>

                            <div class="form-group">
                                 <label for="type">Content Type:</label>
	                             <select name="mtype" id="mtype" required onchange="handleTypeChange()">
			                            <option value="">Select Content</option>
			                            <option value="Movie">Movie</option>
			                            <option value="Show">Show</option>
			                      
                       			 </select>
                            </div>
                        </div>
                        <br>

                        <label for="app_price">Content Price:</label>
                        <input type="number" name="app_price" id="app_price" step="0.01" required><br/><br/>

                        <button type="submit" class="btn btn-1" name="submit"><b>Publish</b></button>

                        <script>
                            function handleTypeChange() {
                                var typeSelect = document.getElementById("type");
                                var priceInput = document.getElementById("app_price");

                                if (typeSelect.value === "Free") {
                                    priceInput.value = "NULL";
                                    priceInput.disabled = true;
                                } else {
                                    priceInput.disabled = false;
                                }
                            }
                        </script>
                    </form>
                </div>

                <div id="my-projects" class="tab-content">
                    <!-- Content for the My Projects tab -->
                    <h2>My Uploads</h2>
                    <table>
                        <tr>
                            <th>Content ID</th>
                            <th>Content Name</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Type</th>
                            <th>Price</th>
                            <th>Uploaded Date</th>
                            <th>Content</th>
                            <th>Delete</th>
                        </tr>

                        <%
                            int userId = (int) session.getAttribute("id");
                            try {
                            	Connection connection = null;
                            	connection = DBConnection.getConnection();
                                String sql = "SELECT * FROM app WHERE userid =" + userId;
                                PreparedStatement stmt = connection.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("category") %></td>
                            <td><%= rs.getString("description") %></td>
                            <td><%= rs.getString("type") %></td>
                            <td><%= rs.getDouble("price") %></td>
                            <td><%= rs.getString("uploaded_date") %></td>                        
                            <td><%= rs.getString("mtype") %></td>
                            <td>
                                <form method="post" action="Deletecontent" onsubmit='return confirm("Are you sure you want to delete this row?");'>
                                    <button type="submit" name="delete" value="<%= rs.getInt("id") %>">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </table>
                </div>



<div id="activity" class="tab-content">
    <h2>Activity</h2>
    <table>
        <tr>
            <th>Session ID</th>
            <th>IP Address</th>
            <th>Logged in Device</th>
            <th>Time</th>
            <th>Date</th>
            <th>Location</th>
        </tr>
        <%-- Replace with your activity data retrieval logic --%>
        <%
            // Example code to retrieve activity data
            try {
            	Connection connection = null;
            	connection = DBConnection.getConnection();
                String query = "SELECT * FROM activity";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery();
                
                while (resultSet.next()) {
        %>
        <tr>
            <td><%= resultSet.getString("session_id") %></td>
            <td><%= resultSet.getString("ip_address") %></td>
            <td><%= resultSet.getString("logged_in_device") %></td>
            <td><%= resultSet.getString("time") %></td>
            <td><%= resultSet.getString("date") %></td>
            <td><%= resultSet.getString("location") %></td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>



<%  
                if (isAdmin) { %>
<div id="inquiries" class="tab-content">
    <h2>Inquiries</h2>
    <table>
        <tr>
            <th>Inquiry ID</th>
            <th>Content Name</th>
            <th>Customer Email</th>
            <th>Phone</th>
            <th>Message</th>
            <th>Status</th>
            <th>Delete</th>
        </tr>
        <%-- Replace with your inquiries data retrieval logic --%>
        <%
            // Example code to retrieve inquiries data
            try {
            	Connection connection = null;
            	connection = DBConnection.getConnection();
                String query = "SELECT id, name, email, phone, message, status FROM contactus";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
        %>
        <tr>
            <td><%= resultSet.getString("id") %></td>
            <td><%= resultSet.getString("name") %></td>
            <td><%= resultSet.getString("email") %></td>
            <td><%= resultSet.getString("phone") %></td>
            <td><%= resultSet.getString("message") %></td>
			<td>
		    <form method="post" action="UpdateStatus">
		        <select name="status" class="status-select">
		            <option value="Pending" <%= "Pending".equals(resultSet.getString("status")) ? "selected" : "" %>>Pending</option>
		            <option value="Completed" <%= "Completed".equals(resultSet.getString("status")) ? "selected" : "" %>>Completed</option>
		        </select>
		        <input type="hidden" name="id" value="<%= resultSet.getString("id") %>">
		        <button type="submit" class="update-status-btn" class="update-status-btn">Update Status</button>
		    </form>
			</td>
			
	        <td>
                 <form method="post" action="DeleteInquiry" onsubmit='return confirm("Are you sure you want to delete this row?");'>
                     <button type="submit" name="delete" value="<%= resultSet.getInt("id") %>" class="delete-btn" >Delete</button>
                 </form>
            </td>
            
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
</div><%} %>

<div id="payment" class="tab-content">
    <h2>Payment Details</h2>
    <table>
        <tr>
            <th>Payment ID</th>
            <th>Content ID</th>
            <th>Content Name</th>
            <th>User ID</th>
            <th>Date</th>
            <th>Payment Method</th>
            <th>Amount</th>
        </tr>
        <%-- Replace with your payment data retrieval logic --%>
        <%
            // Example code to retrieve payment data
            try {
            	Connection connection = null;
            	connection = DBConnection.getConnection();
                String query = "SELECT * FROM payments";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
        %>
        <tr>
            <td><%= resultSet.getString("payment_id") %></td>
            <td><%= resultSet.getString("app_id") %></td>
            <td><%= resultSet.getString("app_name") %></td>
            <td><%= resultSet.getString("user_id") %></td>
            <td><%= resultSet.getString("date") %></td>
            <td><%= resultSet.getString("payment_method") %></td>
            <td><%= resultSet.getString("amount") %></td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>

<%

String developer_id = null;
String named = null;
String email = null;
String bank_account = null;
String paypal_id = null;
String contact_number = null;
String address = null;
String country = null;
String userid = null;



            // Example code to retrieve payment data
            try {
            	Connection connection = null;
            	connection = DBConnection.getConnection();
                String query = "SELECT * FROM developer_settings WHERE userid =" + userId; 
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet result = preparedStatement.executeQuery();

                while (result.next()) {
        
                	developer_id = result.getString("developer_id");
                	named = result.getString("name");
                	email = result.getString("email");
                	bank_account = result.getString("bank_account");
                	paypal_id = result.getString("paypal_id");
		        	contact_number = result.getString("contact_number");
    
		        	address = result.getString("address");
		        	country = result.getString("country");
		        	userid = result.getString("userid");
       
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>

<div id="settings" class="tab-content">
    <h2>Uploader Settings</h2>
    <form method="POST" action="Uploader"  name="action" >
    	
    	<input type="hidden" name="action" value="<%= (named == null) ? 'a' : 'u' %>">
        <label for="developer-id">Uploader ID:</label>
        <span id="developer-id">
           
            <%
                // Example code to retrieve developer ID
                String developerId = developer_id;
            %>
            <%= developerId %>
        </span><br><br>
			
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%=named%>" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%=email%>" required><br>

        <label for="bank-account">Bank Account:</label>
        <input type="text" id="bank-account" name="bank_account" value="<%=bank_account%>" required><br>

        <label for="paypal-id">Paypal ID:</label>
        <input type="text" id="paypal-id" name="paypal_id" value="<%=paypal_id%>" required><br>

        <label for="contact-number">Contact Number:</label>
        <input type="tel" id="contact-number" name="contact_number" value="<%=contact_number%>" required><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%=address%>" required><br>

        <label for="country">Country:</label>
        <input type="text" id="country" name="country" value="<%=country%>" required><br>

        <button type="submit" name="update">Save</button>
    </form>

				</div>
		 </div>
	</div>
  </div>
  
<script src="js/developer.js"></script>



  </body>

<div id="footer"></div>


</html>
 