<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Update/Delete Product</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
    h2, form {
        margin: 0 auto;
		text-align:center;
    }
</style>
<!-- Adding a bit of Javascript to handle different actions !-->
<script>
    function submitForm(action) {
        var form = document.getElementById('productForm');
        form.action = action;
        form.submit();
    }
</script>
</head>
<body>

<h2>Update/Delete a Product</h2>

<%@
 include file = "auth.jsp"
%>
<%@
 include file = "jdbc.jsp"
%>

<%
// Get the list of product names from the database
List<String> productNames = new ArrayList<>();
try {
    getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT productName FROM product");
    while (rs.next()) {
        productNames.add(rs.getString("productName"));
    }
    rs.close();
    stmt.close();
} catch (SQLException ex) {
    out.println("SQLException: " + ex);
} finally {
    closeConnection();
}
%>

<form id="productForm" method="post">
    <label for="productName">Select a Product:</label><br>
    <select id="productName" name="productName">
        <% for (String productName : productNames) { %>
            <option value="<%= productName %>"><%= productName %></option>
        <% } %>
    </select><br>
    <input class = "button" type="button" onclick="submitForm('updateProd.jsp')" value="Update Product">
    <input class = "button" type="button" onclick="submitForm('deleteProd.jsp')" value="Delete Product">
</form>

<!--Returns the user to the admin page-->
<br>
<a href="admin.jsp" class="button">Return to Admin Page</a>

</body>
</html>
