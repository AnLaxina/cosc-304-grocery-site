<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%
// Get the form data
String productName = request.getParameter("productName");
String categoryId = request.getParameter("categoryId");
String productDesc = request.getParameter("productDesc");
String productPrice = request.getParameter("productPrice");

try {
    // Connect to the database
    getConnection();

    // Create a SQL query
    String sql = "INSERT INTO product (productName, categoryId, productDesc, productPrice) VALUES (?, ?, ?, ?)";

    // Create a PreparedStatement
    PreparedStatement pstmt = con.prepareStatement(sql);

    // Set the parameters
    pstmt.setString(1, productName);
    pstmt.setString(2, categoryId);
    pstmt.setString(3, productDesc);
    pstmt.setString(4, productPrice);

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
