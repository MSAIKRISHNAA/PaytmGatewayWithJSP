<%@page import="com.example.dao.ImageDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.util.*" %>  
 <%
 	Random randomGenerator = new Random();
	int randomInt = randomGenerator.nextInt(1000000);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Merchant Check Out Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="GENERATOR" content="Evrsoft First Page">

<link rel="stylesheet" type="text/css" href="css/style3.css" />

<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
</SCRIPT>
</head>
<body >
<%@include file="header_navigation.jsp" %>
<BODY onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<% 

             Random rand = new Random();

            int number = rand.nextInt(9000000) + 1000000;
         
          // int cart_number = 0;
          
         //check user existence in database
          
         // String username = (String)request.getParameter("your_name");
          
         // String password = (String)request.getParameter("your_pass");
          
         // System.out.println("username " + username + "  " + password);
          
          
         
          
          ImageDao dao = new ImageDao();
          
          
         String cust_id =  String.valueOf((Integer)(context.getAttribute("customer_id"))); //first param from logincheck.jsp
          
          Double transaction_amount = (Double)(context.getAttribute("product_cost")); 
 
          String cust_address = dao.get_customer_address((Integer)(context.getAttribute("customer_id"))); // //second param from cartitems.jsp
		
            
		 
		 
		
%>




	<h1>Merchant Check Out Page</h1>
	<pre>
	</pre>
	<form id="msform1" method="post" action="getAddress.jsp">
		<table  style="float: left; width: 80px; margin-left: 5%; margin-right: 5%;" border="1">
			<tbody>
				<tr>
					<th>Shipment Address</th>
					<th><label>CUSTID ::*</label></th>
				</tr>
				<td><textarea rows="5" cols="30"><%= cust_address %></textarea>
					</td>
					
					<td><input  id="CUST_ID" tabindex="2" maxlength="30" size="12" name="CUST_ID" autocomplete="off" value="CUST<%= number %>"></td>
				<tr  >
					
					<td style=" border: none;outline:none;border-collapse:collapse;">
					<button onclick="location.href='updatecart.jsp?product='" class="button button3"> Edit Address</button>
					</td>
				</tr>
				
				
			</tbody>
		</table>
		
		</form>
		
		<form id="msform2" method="post" action="pgRedirect.jsp">
		<table style="float: left;width: 120px;" border="1">
		 <caption style="caption-side: bottom;">client ip address<%= ipaddr %> </caption>
			<tbody>
				<tr>
					<th>S.No</th>
					<th>Label</th>
					<th>Value</th>
				</tr>
				<tr>
					<td>1</td>
					<td><label>ORDER_ID::*</label></td>
					<td><input style=" border:none" class="field left" readonly id="ORDER_ID" tabindex="1" maxlength="14" size="14"
						name="ORDER_ID" autocomplete="off"
						value="ORDS_<%= randomInt %>">
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td><label>CUSTID ::*</label></td>
					<td><input style="border:none" class="field left" readonly id="CUST_ID" tabindex="2" maxlength="40" size="14" name="CUST_ID" autocomplete="off" value="CUST<%= cust_id %>"></td>
				</tr>
				<tr>
					<td>3</td>
					<td><label>INDUSTRY_TYPE_ID ::*</label></td>
					<td><input class="field left" readonly  type="hidden" id="INDUSTRY_TYPE_ID" tabindex="4" maxlength="12" size="12" name="INDUSTRY_TYPE_ID" autocomplete="off" value="Retail"></td>
				</tr>
				<tr>
					<td>4</td>
					<td><label>Channel ::*</label></td>
					<td><input class="field left" readonly  type="hidden" id="CHANNEL_ID" tabindex="4" maxlength="12"
						size="12" name="CHANNEL_ID" autocomplete="off" value="WEB">
					</td>
				</tr>
				<tr>
					<td>5</td>
					<td><label>txnAmount*</label></td>
					<td><input class="field left" readonly  title="TXN_AMOUNT" maxlength="6" size="6" tabindex="10"
						type="text" name="TXN_AMOUNT"
						value="<%= transaction_amount %>">
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td><input value="CheckOut" type="submit"	onclick=""></td>
					
				</tr>
				
			</tbody>
			
		</table>
			
	
	</form>
	
	
	<%


         // String ipaddr = (String)request.getParameter("ipaddress");
         
        
		  
		  
		  %>
</body>
</html>