<%@page import="com.example.dao.ImageDao"%>
<html>
<head>
<title> My First Webpage </title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--  
<link rel="stylesheet" media="screen and (max-width: 360px)" href="css/style.css">
-->
<link rel="stylesheet" media="screen and (min-width: 300px)" href="css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- Load an icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



</head>
<body>


<% 
          int cart_number =0 ;
          String loginstatus = "Log off";

          String ipaddr = (String)request.getSession().getAttribute("myip");
	   
		   
		   ServletContext context = request.getSession().getServletContext();
			
			 
		   if(context.getAttribute("loginstatus") == null ||  (Integer)context.getAttribute("loginstatus") == 0)
		   {
			   context.setAttribute("loginstatus",0);
		             loginstatus = "pls sign in";
		   }
		   else
		   {
		   	    loginstatus = "pls log  off";
		   }
		   
		   ImageDao dao1 = new ImageDao();
			  
			  if(ipaddr != null)
			  {
					 if((Integer)context.getAttribute("loginstatus") == 0)
			       	 {
						  cart_number = dao1.get_number_of_cart_items(ipaddr,0);
			       	 }
			       	 else
			       	 {
			       		 if(context.getAttribute("customer_id") != null)
			       		 {
			       			 cart_number = dao1.get_number_of_cart_items(ipaddr,1);
			       		 }
			       		 
			       		 
			       	 }
				 
			  }
			  else
			  {
				  cart_number  =0;
			  }
			
		   
		  %>
		  
		  <script>
function call_func() {
  //document.getElementById("searchText").value = "Johnny Bravo";
  
  var var1 = "index.jsp?param1=";
 
  var var2 = var1.concat(document.getElementById("searchText").value);
  alert(var2);
  document.location.href =  var2,true;
}
</script>

<div class="navbar" style ="line-height: 2;">
  <a class="active" href="index.jsp"><i class="fa fa-fw fa-home"></i> Home</a> 
  <input type="text"  style="width: 100px;height:36px;border-radius: 10px;" id="searchText" placeholder="Search..">
  <a href="javascript:call_func();"><i class="fa fa-fw fa-search"></i> Search</a> 
  <a href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a> 
  <a href="#"><i class="fa fa-fw fa-user"></i> SMS</a>
  <div class="topnav-right">
  <% 
  if(loginstatus == "pls log  off")
  {
	  System.out.println("header navigation login status pls log off");
	  
	  %>
	   <a href="logout.jsp"><i class="fa fa-fw fa-envelope"></i> <%= loginstatus %></a>
	   
  <% 
  }
  else
  {
	  context.setAttribute("loginstatus",0);
	  System.out.println("header navigation login status pls log in");
  %>
  
 <a href="login.jsp"><i class="fa fa-fw fa-envelope"></i> <%= loginstatus %></a>
 
 <%
 }
 %> 
  

 <a href="cartitems.jsp"><i class="fa fa-fw fa-envelope"></i> Cart <%= cart_number  %> </a>
 
  
  
  
  <a href="#"><i class="fa fa-fw fa-envelope"></i> Contact</a> 
  <a href="#"><i class="fa fa-fw fa-user"></i> login</a>
  </div>
</div>




</body>
</html>