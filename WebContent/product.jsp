<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>A&P's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

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
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();) 
{			
	String query = "SELECT productName, productId, productPrice FROM product WHERE productId = ?";
	PreparedStatement pstmt = con.prepareStatement(query);
	if (productId != null && !productId.isEmpty()) {
        pstmt.setString(1, productId);
    }
	ResultSet rs = pstmt.executeQuery();

	// Print out the ResultSet
	while (rs.next()) {
    	String productName = rs.getString("productName");
    	String productPrice = rs.getString("productPrice");

		// For each product create a link of the form
		// addcart.jsp?id=productId&name=productName&price=productPrice
		out.println("<h2>"+ productName + "</h2><br>");

		// You need to put image here

		out.println("<img <a href=\"displayImage.jsp?id=" + URLEncoder.encode(productId, "UTF-8") 
		+ "\"><h2></h2></a>>");

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


String sql = "";

// TODO: If there is a productImageURL, display using IMG tag

		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

