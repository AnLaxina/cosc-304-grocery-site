<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&P Pharmacy Inventory</title>
	<!-- Add the same style section as in the shop.html page -->
	<link rel="stylesheet" type="text/css" href="style.css">
	<style>
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
	</style>
</head>
<body>

<h1>Warehouse Inventory</h1>

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

String url = "jdbc:sqlserver://cosc304db.database.windows.net:1433;database=304-grocery-site-db;user=cosc304-admin@cosc304db;password=UBC304PW$;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";		
// String uid = "sa";
// String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url);
	    Statement stmt = con.createStatement();) 
{			
	String sql = "SELECT warehouseId, warehouseName " + 
				 "FROM warehouse";

	String sql2 = "SELECT productId, quantity, price " + 
				  "FROM productinventory " + 
				  "WHERE warehouseId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql2);
	

	ResultSet rst = stmt.executeQuery(sql);
	out.println("<table border='1'><tr><th>Warehouse Id</th><th>Warehouse Name</th></tr>");
	while (rst.next())
	{	int warehouseId = rst.getInt(1);
		out.println("<tr><td>"+rst.getInt(1)+"</td>"+
						"<td>"+rst.getString(2)+"</td></tr>");

		/*// Retrieve product
		pstmt.setInt(1, warehouseId);
		ResultSet rst2 = pstmt.executeQuery();
		//out.println("<td></td><td></td><td>");
		out.println("<table border='1'><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		while (rst2.next()) {
			out.println("<tr><td>"+rst2.getInt("productId")+"</td>"+
						"<td>"+rst2.getInt("quantity")+"</td>"
						+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
			}
		out.println("</table>");
		out.println("</td>");
		rst2.close(); */
	}
	out.println("</table>");
	// Close connection
	con.close();
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		

%>
<button onclick="window.location.href='shop.html'" class="main">Return to Main Page</button>
</body>
</html>

