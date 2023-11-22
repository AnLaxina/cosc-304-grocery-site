<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@
 include file = "auth.jsp"
%>
<%@
 include file = "jdbc.jsp"
%>

<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT sum(totalAmount) as amountbyDay" +
            "FROM ordersummary o" +
            "GROUP BY orderDate";

%>

</body>
</html>

