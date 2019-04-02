<%@page import="java.util.TreeMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/style3.css" />

<script type='text/javascript'>

(function()
{
  if( window.localStorage )
  {
    if( !localStorage.getItem('firstLoad') )
    {
      localStorage['firstLoad'] = true;
      window.location.reload();
    }  
    else
      localStorage.removeItem('firstLoad');
  }
})();

</script>
</head>
<body>


<%@include file="header_navigation.jsp" %>



<% 


	TreeMap<String,String> parameters = (TreeMap)context.getAttribute("param");
	if(parameters.get("RESPCODE").equals("01"))
			{
		%>
		<h1 align="center">Transaction Success <%= parameters.get("STATUS") %></h1>
		<% 
			}
	else
	{
		%>
		<h2 style="color:RED;" align="center">Transaction Failure</h2>
		<%
	}
    
	int cust_id = (Integer)context.getAttribute("customer_id");
	
	ImageDao dao = new ImageDao();
	 // dao.delete_cart(ipaddr,1,cust_id);
	 
	 dao.update_show_incart_status(null, 1, cust_id, 0);
	dao.update_product_purchase_status(cust_id, 1);
	
	 
	 
	 
	 
	
	


%>


		<form id="msform2" >
		<table    style="width: 30%; margin-left: auto; margin-right: auto; " align="center" style="float: left;width: 100px;" border="1">
		
			<tbody>
				<tr>
					<th>S.No</th>
					<th>Label</th>
					<th>Value</th>
				</tr>
				<tr>
					<td>1</td>
					<td><label>ORDER_AMOUNT::</label></td>
					<td><input style=" border:none" readonly  class="field left" readonly id="ORDER_AMOUNT" tabindex="1" maxlength="14" size="14"
						name="ORDER_AMOUNT" autocomplete="off" value="<%= parameters.get("TXNAMOUNT") %>">
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td><label>CUSTID ::</label></td>
					<td><input style="border:none" readonly  class="field left" readonly id="CUST_ID" tabindex="2" maxlength="40" size="14" name="CUST_ID" autocomplete="off" value="<%= cust_id %>"></td>
				</tr>
				<tr>
					<td>3</td>
					<td><label>ORDERID ::*</label></td>
					<td><input class="field left" readonly  id="ORDERID" tabindex="4" maxlength="12" size="12" name="ORDERID" autocomplete="off" value="<%= parameters.get("TXNAMOUNT") %>"></td>
				</tr>
		
				<tr>
					<td>4</td>
					<td><label>TXNDATE*</label></td>
					<td><input class="field left" readonly  title="TXNDATE" maxlength="20" size="20" tabindex="10"
						type="text" name="TXNDATE" value="<%= parameters.get("TXNDATE") %>">
					</td>
				</tr>
				
				
			</tbody>
			
		</table>
			
		
	
	</form>
	
	

</body>
</html>