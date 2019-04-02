<!-- this is just comment -->
<!DOCTYPE html>

<%@page import="java.util.UUID"%>
<%@page import="java.util.List"%>
<%@page import="com.example.dao.ImageDao"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
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

<%@include file="header_navigation.jsp" %>




<%
//int cust_id  = 9999;


/*
String loginstatus = "Log off";
if(request.getSession().getAttribute("loginstatus") != null)
{
       session.setAttribute("loginstatus",0);
       loginstatus = "pls sign in";
}
else
{
	 loginstatus = "pls log  off";
}

*/



        // get cart items to display in the cartitems.jsp based on if condition(two tables are used for displaying cart content)
        
		  ImageDao dao = new ImageDao();

          List<List> cartitems = new ArrayList();
		 
		 // int cart_number = dao.get_number_of_cart_items(ipaddr);
		 
		 //*********************************************************************************************
       
		 if((Integer)context.getAttribute("loginstatus") == 0)
		 {
		   cartitems = dao.get_cart_items(ipaddr,0,0);
		 }
		 else
		 {
			 if(context.getAttribute("customer_id") != null)
			 {
			  cartitems = dao.get_cart_items(ipaddr,(Integer)context.getAttribute("customer_id"),1);
			 }
			 
			 
		 }

		 
	
%>








<h1> my website </h1>







<!--
<p class="a">this is first paragraph </p>

<p class="b">this is first paragraph </p>

<div id="demo"></div>

-->

<script>
/*
var txt = "";
txt += "<p>Total width/height: " + screen.width + "*" + screen.height + "</p>";
txt += "<p>Available width/height: " + screen.availWidth + "*" + screen.availHeight + "</p>";
txt += "<p>Color depth: " + screen.colorDepth + "</p>";
txt += "<p>Color resolution: " + screen.pixelDepth + "</p>";

document.getElementById("demo").innerHTML = txt;

*/
</script>

<div class="wrap">
    <!--Updated on 10/8/2016; fixed center alignment percentage-->
    


<div class="fleft">
<div class="div1">
<p id="rcorners1">Category 1</p>

<ul>
  <li><a href="#home">Option 1</a></li>
  <li><a href="#news">Option 2</a></li>
  <li><a href="#contact">Option 3</a></li>
  <li><a href="#about">Option 4</a></li>
  <li><a href="#news">Option 5</a></li>
  <li><a href="#contact">Option 6</a></li>
  <li><a href="#about">Option 7</a></li>
  </ul>
  <p id="rcorners1">Category 2</p>
  <ul>
  <li><a href="#news">Option 8</a></li>
  <li><a href="#contact">Option 9</a></li>
  <li><a href="#about">Option 10</a></li>
  <li><a href="#news">Option 11</a></li>
  <li><a href="#contact">Option 12</a></li>
  <li><a href="#about">Option 13</a></li>
</ul>
</div>


</div>




<div class="fmiddle">
</div>
    
<div class="fright">
<table >
 <col width="150">
  <col width="200">
   <col width="200">
    <col width="200">
    		   <tr>
    <th>Product image</th>
    <th>Product Name</th>
    <th>Quantity</th>
    <th>Price of Each Item</th>
  </tr>
<% 
double total_price = 0;
  for(int i=0;i< cartitems.size();i++)
		  {
		  List<Object> record = cartitems.get(i); //each table row is obtained here in to the list
		  System.out.print("printing each row size " +record.size() + " ");
		  total_price += Double.parseDouble( record.get(2).toString())   * Double.parseDouble( record.get(3).toString()) ;  
		  
		  %>

<tr>
<td >  
		  <div class="gallery1">
		    <img src="img/<%= record.get(1)  %>" alt="Cinque Terre" width="600" height="400">
		    
		    </div>
	
		    </td>
		    
		  
		    <td > <%= record.get(1)  %></td>
		    <td > 
		    
		     <input type="text" id="spinEdit<%= i %>" />
           <script type="text/javascript">
           $('#spinEdit<%= i %>').spinedit('setValue', <%= record.get(2)  %>);
           $('#spinEdit<%= i %>').on("valueChanged", function (e) {
        	    console.log(e.value);
        	    var quan =e.value;
        	    var jspcall = "updatecart.jsp?param1=<%= record.get(1)  %>&param2=";
        	    var jspcall1 = quan;
        	   
        	    var jspcal = jspcall.concat(jspcall1);
        	    window.location.href = jspcal;
        	  
        	});
          
           </script>
           
            </td>
		    <td > <%= record.get(3)  %></td>
		  

</tr>


		  
		
		  <%
		   System.out.println("record will be printed");
		  System.out.print(record.get(0)+ " ");
		  System.out.print(record.get(1)+ " ");
		  System.out.print(record.get(2)+ " ");
		  System.out.print(record.get(3)+ " ");
		 
		  
		  System.out.println("   ");
		  
		  }
  
           context.setAttribute("product_cost",total_price);

%>
<tr>
<td>
</td>
<td>
</td>
<td>
</td>
   <td > <%= total_price  %></td>
 
   </tr>
   <tr>
   <td>
</td>
<td>
</td>
<td>
</td>
      <td >
      <% 
      
     
      if(context.getAttribute("loginstatus") != null && (Integer)context.getAttribute("loginstatus")== 0)
    		{
    	  System.out.println(" from cartitems.jsp  " + "user is not logged in "+context.getAttribute("loginstatus"));
      %>
 <button onclick="location.href='login.jsp?ipaddress=<%= ipaddr %>&product_cost=<%= total_price  %>'" class="button button3"> Checkout Cart</button>  
 <%
    		  } 
     
      
      else
      {
    	  System.out.println("user logged and this line is in cartitems.jsp file ");
    	  
          // String cust_id =  String.valueOf((Integer)(context.getAttribute("customer_id"))); //first param from logincheck.jsp
          
         // Double transaction_amount = (Double)(context.getAttribute("product_cost"));     //second param from cartitems.jsp
 
      
 %>
 <button onclick="location.href='TxnTest.jsp'" class="button button3"> Checkout Cart</button>  
 <%
      }
 %>
 </td>
 </tr>
</table>

		  
</div>

</div>






</body>

</html>