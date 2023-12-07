<%@ page language="java" import="java.io.*,java.sql.*, java.util.HashMap"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
			
			// Checks if userId and password match some customer account. If so, set retStr to be the username.
			// Uses a HashMap to get a list of valid users
			HashMap<String,String> validUsers = new HashMap<String, String>();
			validUsers.put("arnold", "304Arnold!");
			validUsers.put("bobby","304Bobby!");
			validUsers.put("candace", "304Candace!");
			validUsers.put("darren","304Darren!");
			validUsers.put("beth", "304Beth!");
			validUsers.put("anilov","304Anilov!");
			validUsers.put("putri","304Putri!");

			// Checks if the user inputted a valid username
			if(validUsers.containsKey(username)){
				String validPassword = validUsers.get(username);
				if(validPassword.equals(password)){
					retStr = username;
				}
				
			}
						
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>
