<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

	<h1>Customer Profile</h1>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	    Statement stmt = con.createStatement();) 
{		
	String sql;	
	if (!authenticated)
	{
		String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
		out.println(loginMessage);
	} else {
		sql = "SELECT * FROM customer WHERE userId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);
		ResultSet rst = pstmt.executeQuery();

		while(rst.next()){
			out.println("<table border='1'>");
			out.println("<tr><th><b>Id</b></th>"
						+"<td>"+rst.getInt("customerId")+"</td></tr>"
						+"<tr><th><b>First Name</b></th>"
						+"<td>"+rst.getString(2)+"</td></tr>"
						+"<tr><th><b>Last Name</b></th>"
						+"<td>"+rst.getString(3)+"</td></tr>"
						+"<tr><th><b>Email</b></th>"
						+"<td>"+rst.getString(4)+"</td></tr>"
						+"<tr><th><b>Phone</b></th>"
						+"<td>"+rst.getString(5)+"</td></tr>"
						+"<tr><th><b>Address</b></th>"
						+"<td>"+rst.getString(6)+"</td></tr>"
						+"<tr><th><b>City</b></th>"
						+"<td>"+rst.getString(7)+"</td></tr>"
						+"<tr><th><b>State</b></th>"
						+"<td>"+rst.getString(8)+"</td></tr>"
						+"<tr><th><b>Postal Code</b></th>"
						+"<td>"+rst.getString(9)+"</td></tr>"
						+"<tr><th><b>Country</b></th>"
						+"<td>"+rst.getString(10)+"</td></tr>"
						+"<tr><th><b>User ID</b></th>"
						+"<td>"+rst.getString(11)+"</td></tr>");
			out.println("</table>");
		}
		rst.close();
		// Close connection
		con.close();
	}
	
}
catch (SQLException ex)
{
	out.println("SQLException: " + ex);
}		


%>

</body>
</html>

