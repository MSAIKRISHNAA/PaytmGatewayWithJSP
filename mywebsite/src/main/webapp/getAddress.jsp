<%@page import="com.example.dao.ImageDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
String ipaddr = (String)request.getSession().getAttribute("myip");

          ImageDao dao1 = new ImageDao();
		
		  
		  ServletContext context = request.getSession().getServletContext();
		  
		  if (ipaddr != null)
		  {
			  if((Integer)context.getAttribute("loginstatus") == 0)
		       	 {
					int cart_number = dao1.get_number_of_cart_items(ipaddr,0);
		       	 }
		       	 else
		       	 {
		       		 if(context.getAttribute("customer_id") != null)
		       		 {
		       			int cart_number = dao1.get_number_of_cart_items(ipaddr,1);
		       		 }
		       		 
		       		 
		       	 }
		  }
		 
%>	  
</body>
</html>