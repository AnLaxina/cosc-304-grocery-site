<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%
// Get the product name from the request parameters
String productName = request.getParameter("productName");

// Get the current values of the product attributes from the database
String currentProductName = null;
String currentCategoryId = null;
String currentProductDesc = null;
String currentProductPrice = null;
try {
    getConnection();
    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM product WHERE productName = ?");
    pstmt.setString(1, productName);
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        currentProductName = rs.getString("productName");
        currentCategoryId = rs.getString("categoryId");
        currentProductDesc = rs.getString("productDesc");
        currentProductPrice = rs.getString("productPrice");
    }
    rs.close();
    pstmt.close();
} catch (SQLException ex) {
    out.println("SQLException: " + ex);
} finally {
    closeConnection();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
    h2, form {
        margin: 0 auto;
		text-align:center;
    }
</style>
</head>
<body>

<h2>Update Product</h2>

<form action="performUpdate.jsp" method="post">
    <input type="hidden" name="productName" value="<%= productName %>">
    <label for="newProductName">Product Name:</label><br>
    <input type="text" id="newProductName" name="newProductName" value="<%= currentProductName %>"><br>
    <label for="categoryId">Category ID:</label><br>
    <input type="text" id="categoryId" name="categoryId" value="<%= currentCategoryId %>"><br>
    <label for="productDesc">Product Description:</label><br>
    <input type="text" id="productDesc" name="productDesc" value="<%= currentProductDesc %>"><br>
    <label for="productPrice">Product Price:</label><br>
    <input type="text" id="productPrice" name="productPrice" value="<%= currentProductPrice %>"><br>
    <input type="submit" value="Update">
</form>

<!--Returns the user to the admin page-->
<br>
<a href="admin.jsp" class="button">Return to Admin Page</a>

</body>
</html>
