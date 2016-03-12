<html>
<head>
	<title>Confirm Payment</title>
</head>
<body>

<% if(request.getAttribute("InvalidSession")=="T"){ %>

<h1>Invalid Session</h1>

<% }else{ %>

<h2>Payment Confirmed</h2>
<strong>Item Name:</strong> <% out.print(session.getAttribute("Name")); %> <br>
<strong>Item ID:</strong> <% out.print(session.getAttribute("ItemId")); %> <br>
<strong>Buy Price: </strong> <% out.print(session.getAttribute("Price")); %> <br>
<strong>Credit Card: </strong><% out.print(session.getAttribute("credit")); %>

<% } %>

<% session.invalidate(); %>
</body>
</html>