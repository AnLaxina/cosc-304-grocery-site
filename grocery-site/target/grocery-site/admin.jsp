<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
    }

    .button {
    display: inline-block;
    padding: 10px 20px;
    background-color: white;
    border: 1px solid black;
    border-radius: 5px;
    text-decoration: none;
    color: black;
}
</style>
</head>
<body>

<h2>Adminstrator Sales Report by Day</h2>

<%@
 include file = "auth.jsp"
%>
<%@
 include file = "jdbc.jsp"
%>

<%

// Writes SQL query that prints out total order amount by day
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();) {
    String sql = "SELECT FORMAT(orderDate, 'yyyy-MM-dd') as orderDate, SUM(totalAmount) as amountbyDay " +
            "FROM ordersummary " +
            "GROUP BY FORMAT(orderDate, 'yyyy-MM-dd')";

    // Using PreparedStatement
    PreparedStatement pstmt = con.prepareStatement(sql);

    // Execute the query
    ResultSet rs = pstmt.executeQuery();

    // Start table
    out.println("<table>");
    out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");

    // Loop through the result set
    while(rs.next()) {
        out.println("<tr><td>" + rs.getString("orderDate") + "</td><td>" + rs.getDouble("amountbyDay") + "</td></tr>");
    }

    // End table
    out.println("</table>");

    rs.close();
    pstmt.close();
  
        } catch (SQLException ex){
	out.println("SQLException: " + ex);
}	


%>

    <!--Returns the user to the main admin page-->
    <br>
    <a href="index.jsp" class="button">Return to Main Page</a>

</body>
</html>

