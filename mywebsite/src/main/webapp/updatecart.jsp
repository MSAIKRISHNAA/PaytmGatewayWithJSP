<%@page import="org.apache.catalina.Context"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.example.dao.ImageDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%

String product = request.getParameter("product");
String ipaddr = (String)request.getSession().getAttribute("myip");
ServletContext context = request.getSession().getServletContext();


ImageDao dao = new ImageDao();
if(product != null)
{
	int price = (Integer.parseInt((String)request.getParameter("price")));
	System.out.println("product price is "+ price);
	
	
	 //*********************************************************************************************
	
	 if((Integer)context.getAttribute("loginstatus") == 0)
	 {
		 dao.check_and_insert_Item(product,ipaddr,price,0);
	 }
	 else
	 {
		 if(context.getAttribute("customer_id") != null)
		 {
			 dao.check_and_insert_Item(product,ipaddr,price,1);
		 }
		 
		 
	 }
	 

}
//out.println(product);
//out.println("<br>");
//out.println(ipaddr);



// update cart total price when product quantity is changed in cartitems.jsp

String prod = (String)request.getParameter("param1");

System.out.println("product name is "+ prod);
if(prod != null)
{
System.out.println(prod);

int quan =Integer.parseInt(request.getParameter("param2").toString().trim());
System.out.println(quan);

        
        
		   
            
            
//*********************************************************************************************
        	
       	 if((Integer)context.getAttribute("loginstatus") == 0)
       	 {
       		dao.update_cart_item(prod,quan,0);
       	 }
       	 else
       	 {
       		 if(context.getAttribute("customer_id") != null)
       		 {
       			dao.update_cart_item(prod,quan,1);
       		 }
       		 
       		 
       	 }
       	 
            
}
            String redirectURL = "cartitems.jsp";
            response.sendRedirect(redirectURL);
		  
		  %>
</body>
</html>