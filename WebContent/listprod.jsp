<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&P Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

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
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();) 
{			
	String query = "SELECT * FROM product WHERE productName LIKE ?";
	PreparedStatement pstmt = con.prepareStatement(query);
	pstmt.setString(1, "%" + name + "%");  // Use '%' for wildcard search
	ResultSet rs = pstmt.executeQuery();

	while (rs.next()) {
    	String productName = rs.getString("productName");
    	String productPrice = rs.getString("productPrice");
    	String productId = rs.getString("productId");

    	out.println("<a href=\"addcart.jsp?id=" + URLEncoder.encode(productId, "UTF-8") 
        	+ "&name=" + URLEncoder.encode(productName, "UTF-8") 
        	+ "&price=" + URLEncoder.encode(productPrice, "UTF-8") 
        	+ "\">" + productName + "</a><br>");
	}
	
	
	
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>