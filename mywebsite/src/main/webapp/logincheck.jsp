<%@page import="com.example.websiteconstants.WebsiteConstants"%>
<%@page import="java.util.List"%>
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

<%@include file="header_navigation.jsp" %>


<%

          
        
        
		  ImageDao dao = new ImageDao();
          
          String username = (String)request.getParameter("your_name");
          
          String password = (String)request.getParameter("your_pass");
          
          System.out.println("username " + username + "  " + password);	
		 	
%>



</head>
<body>

<%
//insert into orders table from cartitems table
List<Object> l = dao.check_customer_exist(username, password);
int cust_id = (Integer)l.get(0);
int b = (Integer)l.get(1);
if(b == 1) //user present in database
{
	 
	 context.setAttribute("loginstatus",1);
	 System.out.println("*****************user logged in success "+ context.getAttribute("loginstatus"));
	 context.setAttribute("customer_id",cust_id);
	 
	 //insert items into cart
	 
	 //dao.creating_order_from_Cart(ipaddr,cust_id);
	 
	  //deleting items from cart
	 //dao.delete_cart_signout(ipaddr);

	   
	 
	 if(cart_number != 0)
	 {
		 dao.update_cust_id(ipaddr, cust_id);
		boolean status = dao.copy_to_pendingcart_table(cust_id, ipaddr);
		 
		 //dao.update_show_incart_status(ipaddr, cust_id, 0);
        if(status)
        {
        	System.out.println("data pending item insert is succcesful");
         dao.delete_cart(ipaddr,0,0);
         String redirectURL = "http://"+WebsiteConstants.SERVER_NAME+"/cartitems.jsp";
         response.sendRedirect(response.encodeRedirectURL(redirectURL));
         
        }
        else
        {
        	System.out.println("data pending item insert is failed");
        	String redirectURL = "http://"+WebsiteConstants.SERVER_NAME+"/error.jsp";
            response.sendRedirect(response.encodeRedirectURL(redirectURL));
        }
		 
		 //dao.delete_cart_signout(ipaddr);
		 
	 
	 }
	 else
	 {
		 String redirectURL = "http://"+WebsiteConstants.SERVER_NAME+"/index.jsp";
	      response.sendRedirect(response.encodeRedirectURL(redirectURL));
	 }
		 
}
else if(b == 0)
{
	context.setAttribute("userstatus", 0);
	 context.setAttribute("loginstatus",0);
	
	  System.out.println("Customer doesnt exist");
	  String redirectURL = "http://"+WebsiteConstants.SERVER_NAME+"/login.jsp";
      response.sendRedirect(response.encodeRedirectURL(redirectURL));
}
//out.print("user status " +b);

%>
<h1>

<%
//out.print("checkout the cart");
%>
</h1>

</body>
</html>