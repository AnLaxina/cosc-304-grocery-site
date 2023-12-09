<!DOCTYPE html>
<html>
<head>
<title>Delete Product</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
    h2, form, h3 {
        margin: 0 auto;
		text-align:center;
    }
</style>
</head>
<body>

<h2>Delete a Product</h2>

<% String productName = request.getParameter("productName");%>

<br>
<h3>Are you sure you want to delete <%= productName %>?</h3>
<br>

<form action="performDelete.jsp" method="post">
    <input type="hidden" name="productName" value="<%= productName %>">
    <input class="button" type="submit" value="Confirm">
</form>

<!--Returns the user to the admin page-->
<a href="admin.jsp" class="button">Cancel</a>

</body>
</html>
