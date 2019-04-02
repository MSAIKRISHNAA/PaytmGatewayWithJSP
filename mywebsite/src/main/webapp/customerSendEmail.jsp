
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
   String result;
      String to = "abcd@gmail.com";
      String from = "saikrishnaucet@gmail.com";
      String host = "localhost";


   Properties properties = System.getProperties();


properties.setProperty("mail.smtp.host", host);

   // Get the default Session object.
   Session mailSession = Session.getDefaultInstance(properties);

   try{
MimeMessage message = new MimeMessage(mailSession);
message.setFrom(new InternetAddress(from));
message.addRecipients(Message.RecipientType.TO, to);
message.setSubject("This is the Subject Line!");
message.setText("This is actual message");

Transport.send(message);
result = "Success....";
}
catch (MessagingException mex) 
{
mex.printStackTrace();
result = "Error: unable to connect....";
}
%>
<html>
<head>
<title>Send Email using JSP</title>
</head>
<body>
<center>
<h1>Send Email using JSP</h1>
</center>
<p align="center">
<% 
out.println("Result: " + result + "\n");
%>
</p>
</body>
</html>


Read more: http://mrbool.com/how-to-send-email-in-jsp/29157#ixzz5ih3hzoId
