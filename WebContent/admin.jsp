<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
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

    <!-- View the 'Add Product' page -->
    <a href="addProd.jsp" class="button">Add Product</a>

    <!-- Update/delete a product -->
    <a href="updateDeleteProd.jsp" class="button">Update/Delete a Product</a>

    <!--Returns the user to the main admin page-->
    <br>
    <a href="index.jsp" class="button">Return to Main Page</a>
</div>

<%
}
%>
</body>
</html>
