<%@page import="com.example.websiteconstants.WebsiteConstants"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Log out</title>
<link rel="stylesheet" type="text/css" href="css/style3.css" />
</head>
<body>
<h1> Log off Successful</h1>


<%


if(request.getSession().getServletContext() != null)
{
	
	
	
 ServletContext context = request.getSession().getServletContext();
	
if((Integer) context.getAttribute("loginstatus") != null && (Integer)context.getAttribute("customer_id") != 9999 )
   
  {
	System.out.println("we are in logout.jsp");
   //i wnat to remove myArray attribute form contect
  
     context.removeAttribute("loginstatus");
     context.removeAttribute("cutomer_id");
     request.getSession().invalidate();
     
     System.out.println("Logout Successful");
     out.println("Logout Successful");
     
     String redirectURL = "http://"+ WebsiteConstants.SERVER_NAME+"/index.jsp";
     response.sendRedirect(redirectURL);
   
   }
else
{
	 String redirectURL = "http://"+WebsiteConstants.SERVER_NAME+"/index.jsp";
     response.sendRedirect(redirectURL);
}

	 
	 
}




%>

</body>
</html>