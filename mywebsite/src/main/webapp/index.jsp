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
<link rel="stylesheet" media="screen and (min-width: 300px)" href="css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- Load an icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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



		String ip = request.getHeader("X-Forwarded-For");  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("WL-Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_CLIENT_IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getRemoteAddr();  
		}
		
		
          // out.print( request.getRemoteHost() );
        //request.getSession().setAttribute("myip", request.getRemoteHost());
       
      
        //out.print( request.getRemoteAddr() );
        
         request.getSession().setAttribute("myip", ip);
        
		  ImageDao dao = new ImageDao();
		 
		  List[] li  = new ArrayList[10];
		  ArrayList<String> a =new ArrayList();
		  ArrayList<String> b =new ArrayList();
		  int size =12;
		  
          int pageno = 0;    
         if((String)request.getParameter("param1") == null  || request.getParameter("param1") == "" )
         {
		    li = dao.getList(0,"nosearch");
		    System.out.println("the number of images fetched are  "+li[0].size());
		    
         }
         else 
         {
        	 li = dao.getList(1, (String)request.getParameter("param1"));
        	 size = li[0].size();
         }
         
         
         
		  if(li[0].size() != 0 && li[0] != null)
		  {
		  a = new ArrayList<>(li[0].size());
          a.addAll(li[0]);
          
           b = new ArrayList<>(li[1].size());
          b.addAll(li[1]);
		  }
          
		/*  for(String s: a)
		  {
		  System.out.println(" image names are " + s); 
		  }
		  
		  */
		  
		  if(request.getParameter("page") != null)
		  {
		   pageno = Integer.parseInt(request.getParameter("page"));
		   
		   System.out.println("pageno is " +pageno);
		  }
		  
		  UUID uuid = UUID.randomUUID();
	      String rand = uuid.toString();
		  
		  Cookie userIdCookie= new Cookie("userID", rand);
	      userIdCookie.setMaxAge(1*60*60);
		 
	
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
<% 
if(li[0].size() != 0 && li[0] != null)
{
for(int i=0;i<  size ;i++)
{
	if(i==0 || i ==4 || i==8)
	{

	%>
	
<div class="four">
<% 
}
	%>
	

<div class="gallery">
  <a target="_blank" href="img/<%= a.get(i+pageno*9) %>">
    <img src="img/<%= a.get(i+pageno*9)  %>" alt="Cinque Terre" width="600" height="400">
  </a>
  <div class="desc"><%= a.get(i+pageno*9)  %>
  <button onclick="location.href='updatecart.jsp?product=<%= a.get(i+0+pageno*9)  %>&price=<%= b.get(i+0+pageno*9)  %>'" class="button button3"><%= b.get(0+pageno*9)  %> Cart</button>
  </div>
</div>

<% 

if(i==4 || i ==7 || i==11)
	{
	%>
</div>
<%
	}
}
}
%>




</div>


<div class="center" >
  <div class="pagination">
  
  <a href="#">&laquo;</a>
  <% if (pageno == 0){ %>
  <a href="index.jsp?page=0"  class="active">1</a>
  <%} else  { %>
   <a href="index.jsp?page=0" >1</a>
  <% } if (pageno == 1) { %>
  <a href="index.jsp?page=1" class="active">2</a>
   <% } else { %>
   <a href="index.jsp?page=1">2</a>
   <% } if (pageno == 2) { %>
  <a href="index.jsp?page=2"  class="active">3</a>
   <% } else {%>
   <a href="index.jsp?page=2">3</a>
   <% } if (pageno == 3) { %>
  <a href="index.jsp?page=3" class="active">4</a>
   <% } else { %>
     <a href="index.jsp?page=3" >4</a>
  <% } if (pageno == 4) {%>
  <a href="index.jsp?page=4"  class="active">5</a>
   <% } else { %>
    <a href="index.jsp?page=4" >5</a>
      <% } %>
  <a href="#">&raquo;</a>
  </div>
</div>


</body>

</html>