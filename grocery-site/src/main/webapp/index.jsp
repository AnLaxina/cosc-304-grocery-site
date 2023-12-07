<!DOCTYPE html>
<html>

<head>
        <title>A&P Pharmacy Main Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
        <!-- Add a logo for the website -->
		<div style="text-align: center;">
       		 <img src="logo.png" alt="A&P Pharmacy Logo" class="logo">
		</div>

        <!-- Create a navigation bar with links -->
        <div class="navbar">
                <a href="login.jsp">Login</a>
                <a href="customer.jsp">Customer Info</a>
                <a href="admin.jsp">Administrators</a>
                <a href="logout.jsp">Log out</a>
        </div>

        <!-- Create a main content section with buttons -->
        <div class="main">
                <h1>Welcome to A&P Pharmacy</h1>
                <button onclick="window.location.href='listprod.jsp'">Begin Shopping</button>
                <button onclick="window.location.href='listorder.jsp'">List All Orders</button>
        </div>

        <!-- Create a footer section with links -->
        <div class="footer">
                <a href="ship.jsp?orderId=1">Test Ship orderId=1</a>
                <a href="ship.jsp?orderId=3">Test Ship orderId=3</a>
        </div>
</body>
</html>