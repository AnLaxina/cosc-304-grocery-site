<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<%
// Get the form data
String productName = request.getParameter("productName");

try {
    // Connect to the database
    getConnection();

    // Create a SQL query
    String sql = "DELETE FROM product WHERE productName = ?";

    // Create a PreparedStatement
    PreparedStatement pstmt = con.prepareStatement(sql);

    // Set the parameters
    pstmt.setString(1, productName);

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
