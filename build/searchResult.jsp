<% 
	String[] ids = (String[]) request.getAttribute("idList");
	String[] names = (String[]) request.getAttribute("nameList");
	int start = (Integer) request.getAttribute("start");
	int numResults = (Integer) request.getAttribute("numResults");
	int start_if_click_previous;
	int start_if_click_next;
	if (start-25 < 0)
		start_if_click_previous = 0;
	else
		start_if_click_previous = start - 25;

	if (numResults == 25)
		start_if_click_next = start + 25;
	else
		start_if_click_next = start;
%>
<html>
<head>
    <title>Result</title>
    <script type="text/javascript" src="autosuggest2.js"></script>
        <script type="text/javascript" src="suggestions2.js"></script>
        <link rel="stylesheet" type="text/css" href="autosuggest.css" />
        <script type="text/javascript">
 			var xmlHttp = new XMLHttpRequest(); // works only for Firefox, Safari, ...
 			
 			window.onload = function () {
                var oTextbox = new AutoSuggestControl(document.getElementById("txt1"), new StateSuggestions(xmlHttp));        
            }
		</script>
</head>
<body>
	<form method=GET action="search">
		Keyword: <input id="txt1" type="text" name="q" size=60 autocomplete="off" required><br>
		<input type="hidden" name="numResultsToSkip" value="0" >
		<input type="hidden" name="numResultsToReturn" value="25" >
		<input type=submit value="search">
	</form>
	
	<%
		if (numResults==0) {
			%>
			<h1>No results found</h1>
			<%
		} else {
			%>
		    <table border="2" style="width:100%">
		    <tr>
		    	<td>Number</td>
		    	<td>ItemId</td>
		    	<td>Name</td>
		    </tr>
			<%
			    for ( int i = 0; i < ids.length; i++ ) {
			        %>
			        <tr>
			        <td><%= i + start + 1%></td>
			        <td><a href="item?itemId=<%=ids[i]%>"><%= ids[i] %></a></td>
			        <td><%= names[i] %></td>
			        </tr>
			        <%
			    }
			%>
			</table>

			<div>
				<form method=GET action="search">
					<input type="hidden" name="q" value=<%= request.getParameter("q") %> >
					<input type="hidden" name="numResultsToSkip" 
									 value=<%= start_if_click_previous %> ><br>
					<input type="hidden" name="numResultsToReturn" value="25" >
					<input type=SUBMIT value="Previous Page">
				</form>
			
				<form method=GET action="search">
					<input type="hidden" name="q" value=<%= request.getParameter("q") %> >
					<input type="hidden" name="numResultsToSkip" 
									 value=<%= start_if_click_next %> ><br>
					<input type="hidden" name="numResultsToReturn" value="25" >
					<input type=SUBMIT value="Next Page">
				</form>
			</div>
			<%
		}
	%>
</body>
</html>