<html>
<head>
<title>Hello World in JSP</title>
</head>
<body>

<% out.println("Hello World!"); 
 out.println("Also the date is: " + new java.util.Date()); %>
<p>Also <strong>He-Man!</strong></p>
<% if(3 == 3){
    out.println("Wow! 3 equals 3!");
}
%>

</body>
</html>