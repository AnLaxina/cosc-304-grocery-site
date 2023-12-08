<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%
// Get the form data
String productName = request.getParameter("productName");
String newProductName = request.getParameter("newProductName");
String categoryId = request.getParameter("categoryId");
String productDesc = request.getParameter("productDesc");
String productPrice = request.getParameter("productPrice");

try {
    // Connect to the database
    getConnection();

    // Create a SQL query
    String sql = "UPDATE product SET productName = ?, categoryId = ?, productDesc = ?, productPrice = ? WHERE productName = ?";

    // Create a PreparedStatement
    PreparedStatement pstmt = con.prepareStatement(sql);

    // Set the parameters
    pstmt.setString(1, newProductName);
    pstmt.setString(2, categoryId);
    pstmt.setString(3, productDesc);
    pstmt.setString(4, productPrice);
    pstmt.setString(5, productName);

    // Execute the query
    pstmt.executeUpdate();

    // Close the PreparedStatement
    pstmt.close();

} catch (SQLException ex) {
    out.println("SQLException: " + ex);
} finally {
    // Close the database connection
    closeConnection();
}
%>

<!--Redirects the user to the admin page-->
<jsp:forward page="admin.jsp"/>
