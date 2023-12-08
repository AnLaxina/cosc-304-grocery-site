<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
    h2, form {
        margin: 0 auto;
		text-align:center;
    }

</style>
</head>
<body>

<h2>Add a New Product</h2>

<form action="insertProd.jsp" method="post">
    <label for="productName">Product Name:</label><br>
    <input type="text" id="productName" name="productName"><br>
    <label for="categoryId">Category ID: (1 = Health Monitoring Devices, 2 = First-Aid Supplies, 3 = Skincare, 4 = Over-the-Counter Medication) </label><br>
    <input type="text" id="categoryId" name="categoryId"><br>
    <label for="productDesc">Product Description:</label><br>
    <input type="text" id="productDesc" name="productDesc"><br>
    <label for="productPrice">Product Price:</label><br>
    <input type="text" id="productPrice" name="productPrice"><br>
    <input type="submit" value="Submit">
</form>

<!--Returns the user to the admin page-->
<br>
<a href="admin.jsp" class="button">Return to Admin Page</a>

</body>
</html>
