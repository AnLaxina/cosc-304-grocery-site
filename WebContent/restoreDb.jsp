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

<h2>Restore Database</h2>

<br>
<h3>Are you sure you want to restore the database?</h3>
<h3>This WILL restore the database to its original form including having only 11 items and all orders will be gone!<h3>
<br>


<form action="performRestore.jsp" method="post">
    <input class="button" type="submit" value="Confirm">
</form>

<!--Returns the user to the admin page-->
<a href="admin.jsp" class="button">Cancel</a>

</body>
</html>
