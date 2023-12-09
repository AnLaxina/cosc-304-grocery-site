<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>A&P Grocery</title>
	<!-- Add the same style section as in the shop.html page -->
	<link rel="stylesheet" type="text/css" href="style.css">
	<!-- Add some additional style rules for the search form and the table -->
	<style>
		/* Style the search form */
		.search-form {
			display: flex;
			justify-content: center;
			align-items: center;
			margin: 20px;
			padding: 20px;
			font-size: 18px;
			color: #03045E;
			border: 2px solid #0077B6;
			border-radius: 15px;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}

		/* Style the input field in the search form */
		.search-form input[type="text"] {
			width: 300px;
			margin: 10px;
			padding: 10px;
			border: 1px solid #0077B6;
			border-radius: 10px;
		}

		/* Style the table */
		table {
			width: 80%;
			margin: 0 auto;
			border-collapse: collapse;
		}

		/* Style the table header */
		th {
			height: 50px;
			background-color: #0077B6;
			color: white;
			text-align: center;
			font-weight: bold;
		}

		/* Style the table cells */
		td {
			height: 100px;
			padding: 10px;
			text-align: center;
			vertical-align: middle;
		}

		/* Alternate the background color of the table rows */
		tr:nth-child(even) {
			background-color: #F0F2F5;
		}

		tr:nth-child(odd) {
			background-color: #E0E0E0;
		}

		/* Style the product image */
		.product-image {
			width: 80px;
			height: 80px;
			object-fit: cover;
		}
	</style>
</head>
<body>

<!-- Add the same logo and navbar as in the shop.html page -->
<img src="logo.png" alt="A&P Grocery Logo" class="logo">

<!-- Style the search form and the table -->
<div class="search-form">
	<form method="get" action="listprod.jsp">
	<input type="text" name="productName" size="50" placeholder="Enter product name...">
	<button type="submit">Submit</button>
	<button type="reset">Reset</button>
	</form>
</div>

<table border='1'>
	<tr>
		<th>Name</th>
		<th>Product</th>
		<th>Category</th>
		<th>Price</th>
		<th>Image</th>
	</tr>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
// String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
// String uid = "sa";
// String pw = "304#sa#pw";
String url = "jdbc:sqlserver://cosc304db.database.windows.net:1433;database=304-grocery-site-db;user=cosc304-admin@cosc304db;password=UBC304PW$;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url);
	    Statement stmt = con.createStatement();) 
{			
	String query;
    if (name != null && !name.isEmpty()) {
        query = "SELECT * FROM product p " +
		"JOIN category c ON p.categoryId = c.categoryId WHERE productName LIKE ?";
    } else {
        query = "SELECT * FROM product p " +
		"JOIN category c ON p.categoryId = c.categoryId";
    }
	PreparedStatement pstmt = con.prepareStatement(query);
	if (name != null && !name.isEmpty()) {
        pstmt.setString(1, "%" + name + "%");  // Use '%' for wildcard search
    }
	ResultSet rs = pstmt.executeQuery();

	// Print out the ResultSet
	while (rs.next()) {
    	String productName = rs.getString("productName");
    	String productPrice = rs.getString("productPrice");
    	String productId = rs.getString("productId");
		String category = rs.getString("categoryName");

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice
		out.println("<tr>");
		out.println("<td><a href=\"addcart.jsp?id=" + URLEncoder.encode(productId, "UTF-8") 
			+ "&name=" + URLEncoder.encode(productName, "UTF-8") 
			+ "&price=" + URLEncoder.encode(productPrice, "UTF-8") 
			+ "\">Add to Cart</a></td>");
		out.println("<td><a href=\"product.jsp?id=" + URLEncoder.encode(productId, "UTF-8") 
			+ "\">" + productName + "</a></td>");
    	out.println("<td>" + category + "</td>");
    	out.println("<td>" + "$" + productPrice + "</td>");
    	// Add a column for the product image
    	out.println("<td><img src=\"img/" + productId + ".jpg\" alt=\"" + productName + "\" class=\"product-image\"></td>");
    	
    	out.println("</tr>");
	}
	// Close connection
	con.close();
	
	
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>
</table>

<div class="footer">
        <a href="index.jsp">Return to main page</a>
</div>

</body>
</html>