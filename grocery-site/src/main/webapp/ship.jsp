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
	// Get order id
	String orderId = request.getParameter("orderId");
          
	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	// Make the connection
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				
	try ( Connection con = DriverManager.getConnection(url, uid, pw); ) 
	{	
		// Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		
		// Check if valid order id in database
		String sql = "SELECT COUNT(*) FROM orderProduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, orderId);
		ResultSet rs = pstmt.executeQuery();
		if (!rs.next() || rs.getInt(1) == 0) {
			out.println("Invalid order id: " + orderId);
			return;
		}
		
		// Retrieve all items in order with given id
		sql = "SELECT *, pi.quantity AS prevQuantity FROM orderproduct op "
			+"JOIN productinventory pi ON op.productId = pi.productId "
			+"WHERE orderId = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, orderId);
		rs = pstmt.executeQuery();
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
				out.println("<h2>Shipment not done. Insufficient inventory for product id: "+ productId +"</h2>");
				count++;
			} else {
				out.println("<h2>Ordered Product: "+productId
					+" Qty: "+quantity
					+" Previous Inventory: "+prevInventory
					+" New Inventory: "+newInventory+"</h2>");
				out.println("<br>");

				// Update inventory for each item
				sql = "UPDATE productinventory SET quantity = ? WHERE productId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, newInventory);
				pstmt.setString(2, productId);
				pstmt.executeUpdate();
			}
		}
		
        if(count==0){
			out.println("<h2>Shipment successfully processed.</h2>");
			out.println("<br>");
		}

		// If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, commit transaction
		if (count > 0) {
			con.rollback();
		} else {
			con.commit();
		}
		
		// Auto-commit should be turned back on
		con.setAutoCommit(true);
		
		// Create a new shipment record
        int warehouseId = 1;
		sql = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setDate(1, java.sql.Date.valueOf(java.time.LocalDate.now()));
		pstmt.setInt(2, warehouseId);
		pstmt.executeUpdate();
		
		// Close connection
		con.close();
	}
	catch (SQLException ex)
	{
		out.println("SQLException: " + ex);
	}		

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
