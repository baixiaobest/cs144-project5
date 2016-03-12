<html>
<head>
	<title>Buy Item</title>
</head>
<body>
	<%
		if(request.getAttribute("InvalidSession")=="N"){
	%>
	<p>Invalid Session</p>
	<% 
		}else{
	%>
	
	<%if(session.getAttribute("ItemId")!=null){ %>

	<strong>Item Name:</strong> <% out.print(session.getAttribute("Name")); %> <br>
	<strong>Item ID:</strong> <% out.print(session.getAttribute("ItemId")); %> <br>
	<strong>Buy Price: </strong> <% out.print(session.getAttribute("Price")); %> <br>
	<form method="POST" action="https://localhost:8443/eBay/confirm">
		<strong>Credit Card: </strong><input id="entry" type="text" name="credit" maxlength="20" required> </br>
		<P><INPUT TYPE=SUBMIT value="Submit Payment"> </br> 
	</form>
	<% }else{%>
		<h2>Please go back to item page, refresh and click "Pay Now" </h2>
	<% } %>

	<%
		}
	%>
</body>
</html>