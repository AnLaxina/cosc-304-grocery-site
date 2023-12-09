<%@ page import="java.sql.*, java.io.*, java.nio.file.*" %>
<%@ include file="jdbc.jsp" %>

<%
    // Connect to the database
    getConnection();

    // Read the DDL file from the actual tomcat directory
    // Apparently the actual working directory is under tomcat? lol
    String ddlPath = application.getRealPath("/ddl/medicine-database.ddl");
    String ddl = new String(Files.readAllBytes(Paths.get(ddlPath)));


    // Split the DDL into individual statements
    String[] statements = ddl.split(";");

    // Execute each statement
    for (String statement : statements) {
        try (Statement stmt = con.createStatement()) {
            stmt.execute(statement);
        }
    }
  
   

    // Close the database connection
    closeConnection();
%>

<!--Redirects the user to the admin page-->
<jsp:forward page="admin.jsp"/>
