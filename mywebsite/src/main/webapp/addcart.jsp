<%@page import="com.example.dao.ImageDao"%>

<html>
<body>
<h2>Hello World!</h2>
<%
String product = request.getParameter("product");
String ipaddr = (String)request.getSession().getAttribute("myip");


ImageDao dao = new ImageDao();

//**********************************************************************************************
ServletContext context = request.getSession().getServletContext();

if((Integer)context.getAttribute("loginstatus") == 0)
{
	dao.check_and_insert_Item(product,ipaddr,300,0);
}
else
{
	 if(context.getAttribute("customer_id") != null)
	 {
		 dao.check_and_insert_Item(product,ipaddr,300,1);
	 }
	 
	 
}


out.println(product);
out.println("<br>");
out.println(ipaddr);





%>


</body>
</html>
