<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>A&P Grocery Order Processing</title>
<style>
    body{
        background-color: lightblue;
    }
</style>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    Connection con = DriverManager.getConnection(url, uid, pw);

    // Validate customer id
    PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM customer WHERE customerId = ?");
    ps.setString(1, custId);
    ResultSet rs = ps.executeQuery();
    rs.next();
    if (rs.getInt(1) == 0) {
        out.println("<h2>Invalid customer id.</h2>");
        return;
    }

    // Check if shopping cart is empty
    if (productList == null || productList.isEmpty()) {
        out.println("<h2>Shopping cart is empty!</h2>");
        return;
    }

    // Insert into OrderSummary table
    String sql = "INSERT INTO ordersummary (customerId, orderDate) VALUES (?, GETDATE())";
    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setString(1, custId);
    pstmt.executeUpdate();
    ResultSet keys = pstmt.getGeneratedKeys();
    keys.next();
    int orderId = keys.getInt(1);

    // Traverse through productList and insert into orderProduct table
    double totalAmount = 0;
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

    // Start of Order Summary Table
    out.println("<h2>Order Summary</h2>");
    out.println("<table border='1'>");
    out.println("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
    while (iterator.hasNext()) { 
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        String productName = (String) product.get(1);
        String productId = (String) product.get(0);
        double price = Double.parseDouble((String) product.get(2));
        int qty = (Integer) product.get(3);

        // Insert row into Order Summary Table
        out.println("<tr><td>" + productId + "</td><td>" + productName + "</td><td>" + qty + "</td><td>" + "$" + price + "</td><td>" + "$" + price + "</td></tr>");

        sql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, orderId);
        pstmt.setString(2, productId);
        pstmt.setInt(3, qty);
        pstmt.setDouble(4, price);
        pstmt.executeUpdate();

        totalAmount += price * qty;
    }

    // End of Order Summary Table
    out.println("</table>");

    // Update total amount for order record
    sql = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
    pstmt = con.prepareStatement(sql);
    pstmt.setDouble(1, totalAmount);
    pstmt.setInt(2, orderId);
    pstmt.executeUpdate();

    // Display order information
    out.println("<br>");
    out.println("<h3>Order placed successfully! Reference Number: " + orderId + "<br> Total Amount: " + "$" + totalAmount + "</h3>");

    // Clear shopping cart
    session.removeAttribute("productList");

    // Close connection
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} catch (Exception e) {
    e.printStackTrace();
} 
%>
</BODY>
</HTML>
