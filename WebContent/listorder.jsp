<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&Q Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0));  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();) 
{			
	String sql = "SELECT orderId, orderDate, o.customerId, CONCAT(firstName,' ', lastName) as customerName, totalAmount " + 
				 "FROM ordersummary o " + 
				 "JOIN customer c ON c.customerId = o.customerId";

	String sql2 = "SELECT p.productId, quantity, (productPrice*quantity) as price " + 
				  "FROM product p " + 
				  "JOIN orderproduct op ON p.productId = op.productId " + 
				  "WHERE orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql2);
	

	ResultSet rst = stmt.executeQuery(sql);
	out.println("<table border='1'><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst.next())
	{	int orderId = rst.getInt(1);
		out.println("<tr><td>"+rst.getInt("orderId")+"</td>"+
						"<td>"+rst.getDate(2)+"</td>"
						+"<td>"+rst.getInt(3)+"</td>"
						+"<td>"+rst.getString(4)+"</td>"
						+"<td>"+currFormat.format(rst.getDouble(5))+"</td></tr>");

		// Retrieve product
		pstmt.setInt(1, orderId);
		ResultSet rst2 = pstmt.executeQuery();
		out.println("<td></td><td></td><td colspan='5'>");
		out.println("<table border='1'><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		while (rst2.next()) {
			out.println("<tr><td>"+rst2.getInt(1)+"</td>"+
						"<td>"+rst2.getInt(2)+"</td>"
						+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
			}
		out.println("</table>");
		out.println("</td>");
		rst2.close();
	}
	out.println("</table>");
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		


// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

