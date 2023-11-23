<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>A&P Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");
          
	// TODO: Check if valid order id in database
	//if(orderId )
	
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
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
				
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) 
	{			
		String sql = "SELECT *, pi.quantity AS prevQuantity FROM orderproduct op "
					+"JOIN productinventory pi ON op.productId = pi.productId "
					+"WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		if (orderId != null && !orderId.isEmpty()) {
			pstmt.setString(1, orderId);
		}
		ResultSet rs = pstmt.executeQuery();
		int count=0;

		// Print out the ResultSet
		while (rs.next()) {
			String productId = rs.getString("productId");
			int quantity = rs.getInt("quantity");
			int prevInventory = rs.getInt("prevQuantity");
			int newInventory = prevInventory - quantity;
			

			// For each product create a link of the form
			// addcart.jsp?id=productId&name=productName&price=productPrice
			if(quantity > prevInventory){
				out.println("<b>Shipment not done. Insufficient inventory for product id: "+ productId +"</b>");
				count++;
			} else {
				out.println("<h2>Ordered Product: "+productId
					+" Qty: "+quantity
					+" Previous Inventory: "+prevInventory
					+" New Inventory: "+newInventory+"</h2>");
				out.println("<br>");
			}
			
		}
		if(count==0){
			out.println("<h2>Shipment Succesfuly Processed</h2>");
			out.println("<br>");
		}
		// Close connection
		con.close();
	}
	catch (SQLException ex)
	{
		out.println("SQLException: " + ex);
	}		

	// TODO: Create a new shipment record.


	// TODO: For each item verify sufficient quantity available in warehouse 1.

	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
