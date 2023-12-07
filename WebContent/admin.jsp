<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
    .button {
            display: block;
            width: 200px; 
            margin: 10px auto; 
            padding: 10px 20px;
            font-size: 20px;
            cursor: pointer;
            text-decoration: none;
            color: whitesmoke;
            background-color: #0077B6;
            border: none;
            border-radius: 15px;
            transition: 0.3s;
    }
    .container {
            text-align: center; 
    }
</style>
</head>
<body>

<%
// Check if a user is logged in
if (session.getAttribute("authenticatedUser") == null) {
    // If not, redirect to the login page
    response.sendRedirect("login.jsp");
} else {
    // If so, display the admin page
%>

<div class="container">
    <!-- Your admin page HTML code goes here -->
    <h2>Welcome to the Administrator Page</h2>

    <!-- Add a button to view total sales -->
    <a href="salesReport.jsp" class="button">View Total Sales</a>

    <!-- Add more buttons as needed for other admin functions -->

    <!--Returns the user to the main admin page-->
    <br>
    <a href="index.jsp" class="button">Return to Main Page</a>
</div>

<%
}
%>
</body>
</html>
