<%@page import="com.example.dao.ImageDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title> My First Webpage </title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--  
<link rel="stylesheet" media="screen and (max-width: 360px)" href="css/style.css">
-->

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- Load an icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/bootstrap-spinedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap-spinedit.css" />

<link rel="stylesheet" media="screen and (min-width: 300px)" href="css/style.css">






</head>
<body>

<%
          int cart_number =0;

          String ipaddr = (String)request.getSession().getAttribute("myip");
        
        
		  ImageDao dao = new ImageDao();
		  
		  ServletContext context = request.getSession().getServletContext();
		 
		  if((Integer)context.getAttribute("loginstatus") == 0)
	       	 {
				 cart_number = dao.get_number_of_cart_items(ipaddr,0);
	       	 }
	       	 else
	       	 {
	       		 if(context.getAttribute("customer_id") != null)
	       		 {
	       			 cart_number = dao.get_number_of_cart_items(ipaddr,1);
	       		 }
	       		 
	       		 
	       	 }
        
		  
		  //insert user details into database
          
          String username = (String)request.getParameter("name");
          
          String password = (String)request.getParameter("pass");
          
          String email = (String)request.getParameter("email");
          
          String addr = (String)request.getParameter("address");
          
          System.out.println("username " + username + "  " + password);
          
		  
		  
		 
		
%>


<div class="navbar">
  <a class="active" href="index.jsp"><i class="fa fa-fw fa-home"></i> Home</a> 
  <a href="#"><i class="fa fa-fw fa-search"></i> Search</a> 
  <a href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a> 
  <a href="#"><i class="fa fa-fw fa-user"></i> Login</a>
  <div class="topnav-right">
  <a href="cartitems.jsp"><i class="fa fa-fw fa-envelope"></i> Cart <%= cart_number  %> </a>
  <a href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a> 
  <a href="#"><i class="fa fa-fw fa-user"></i> Login</a>
  </div>
</div>

<%

dao.insert_customer_data(username, password, email, addr);
out.print("user inserted into database");

%>

<h1>

<%
out.print("checkout the cart");
%>
</h1>

</body>
</html>