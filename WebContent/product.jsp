<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>A&P's Grocery - Product Information</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style>
	*{
		margin: 0 auto;
		text-align:center;
	}
	
</style>
</head>
<body>

<div class="container">
        <img src="logo.png" alt="A&P Pharmacy Logo" class="logo">
</div>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make the connection
String url = "jdbc:sqlserver://cosc304db.database.windows.net:1433;database=304-grocery-site-db;user=cosc304-admin@cosc304db;password=UBC304PW$;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";		
// String uid = "sa";
// String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url);
	    Statement stmt = con.createStatement();) 
{			
	String query = "SELECT productName, productId, productPrice, productDesc FROM product WHERE productId = ?";
	PreparedStatement pstmt = con.prepareStatement(query);
	if (productId != null && !productId.isEmpty()) {
        pstmt.setString(1, productId);
    }
	ResultSet rs = pstmt.executeQuery();

	// Print out the ResultSet
	while (rs.next()) {
    	String productName = rs.getString("productName");
    	String productPrice = rs.getString("productPrice");
		String productDesc = rs.getString("productDesc");

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice
		out.println("<h2>"+ productName + "</h2><br>");

		// Instead of retrieving it from the database, we will get it locally instead
		// out.println("<img src=\"displayImage.jsp?id=" + URLEncoder.encode(productId, "UTF-8") + "\">");
		out.println("<img src=img/" + productId + ".jpg>");

		out.println("<br>");
		out.println("<strong>Product Description: </strong>");
		out.print(productDesc);
		out.println("<br>");
		out.println("<b>Product Id: </b>");
		out.println(productId+ "<br>");
		out.println("<b>Price: </b>");
    	out.println("$" + productPrice + "<br>");
		out.println("<a href=\"addcart.jsp?id=" + URLEncoder.encode(productId, "UTF-8") 
			+ "&name=" + URLEncoder.encode(productName, "UTF-8") 
			+ "&price=" + URLEncoder.encode(productPrice, "UTF-8") 
			+ "\"><h2>Add to Cart</h2></a>");
		out.println("<a href=\"listprod.jsp?id=" 
			+ "\"><h2>Continue Shopping</h2></a>");
	}
	// Close connection
	con.close();
	
	
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		



// TODO: If there is a productImageURL, display using IMG tag

		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

