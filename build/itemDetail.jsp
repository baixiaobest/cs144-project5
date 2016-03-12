<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%
	String dump = (String) request.getAttribute("dump");
%>

<c:if test="${dump != \"\"}">
<x:parse xml="${dump}" var="output"/>
</c:if>

<html>
<head>
	<title>Item Info</title>
	<script type="text/javascript" 
    src="http://maps.google.com/maps/api/js?sensor=false"> 
	</script> 
	<script type="text/javascript"> 
		var defaultMode = false;
		var Zoom = 12;
  		function initialize() { 
  			var latitude=document.getElementById("Lat").innerHTML;
  			var longitude=document.getElementById("Lng").innerHTML;
  			if(latitude=="" || longitude==""){
  				defaultMode = true;
  				latitude="0";
  				longitude="0";
  				Zoom = 1;
  			}else{
  				defaultMode = false;
  			}

    		var latlng = new google.maps.LatLng(parseFloat(latitude),parseFloat(longitude)); 
    		var myOptions = { 
      		zoom: Zoom, // default is 8  
      		center: latlng, 
      		mapTypeId: google.maps.MapTypeId.ROADMAP 
    		}; 
    		var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions); 

    		var geocoder=new google.maps.Geocoder();
    		var address = document.getElementById("location").innerHTML +", " + document.getElementById("country").innerHTML;
    		console.log(address);
    		geocoder.geocode({'address': address},function(results, status){
    			if (status == google.maps.GeocoderStatus.OK){
    				if(defaultMode){
    					map.setCenter(results[0].geometry.location);
    					map.setZoom(12);
    				}
    			}
    		});
  		} 

</script>
</head>
<body onload="initialize()">

<form method=GET action="item">
	ItemID: <input id="entry" type="text" name="itemId" size=20 required></br>
	<P><INPUT TYPE=SUBMIT> </br> </br> 
</form>

<c:choose>
	
	<c:when test="${dump != \"\"}">

	<strong>Item Name:</strong> <x:out select="$output/Item/Name" /> </br>
	<strong>ID:</strong> <x:out select="$output/Item/@ItemID" /> </br>
	<strong>Categories:</strong> <x:forEach select="$output/Item/Category" var="cat"> <x:out select="$cat" />, </x:forEach> </br>
	<strong>Currently:</strong> <x:out select="$output/Item/Currently" />  </br>
	<strong>First Bid:</strong> <x:out select="$output/Item/First_Bid" />  </br>
	<strong>Number of Bid(s):</strong> <x:out select="$output/Item/Number_of_Bids" /> </br>
	<x:if select="$output/Item/Buy_Price">
		<strong>Buy Price: </strong><x:out select="$output/Item/Buy_Price"/></br>
		<form method=GET action="buy">
			<Input type="hidden" name="itemId" value="<x:out select="$output/Item/@ItemID" />">
			<INPUT TYPE=SUBMIT value="Pay Now">
		</form>
	</x:if>
	<ul>
	<x:forEach select="$output/Item/Bids/Bid" var="bid">
	<li> <strong>Bidder:</strong> <x:out select="$bid/Bidder/@UserID"/>  </br>
		<strong>Rating:</strong> <x:out select="$bid/Bidder/@Rating"/>
		<x:if select="$bid/Bidder/Location"> </br>
		<strong>Location:</strong> <x:out select="$bid/Bidder/Location" /> </br>
		</x:if>
		<x:if select="$bid/Bidder/Country">
		<strong>Country:</strong> <x:out select="$bid/Bidder/Country" /> </br>
		</x:if>
		<strong>Time:</strong> <x:out select="$bid/Time"/> </br>
		<strong>Amount:</strong> <x:out select="$bid/Amount" /> </br>
		</br>
	</li>
	</x:forEach>
	</ul>

	<strong>Location:</strong> <span id="location"><x:out select="$output/Item/Location"/></span> </br>
	<strong>Country:</strong> <span id="country"><x:out select="$output/Item/Country"/></span> </br>
	<strong>Latitude:</strong> <span id="Lat"><x:out select="$output/Item/Location/@Latitude" /></span> </br>
	<strong>Longitude:</strong> <span id="Lng"><x:out select="$output/Item/Location/@Longitude" /></span> </br>
	
	<strong>Started:</strong> <x:out select="$output/Item/Started"/> </br>
	<strong>Ends:</strong> <x:out select="$output/Item/Ends"/> </br>
	<strong>Seller:</strong> <x:out select="$output/Item/Seller/@UserID"/>
	<strong>Rating:</strong> <x:out select="$output/Item/Seller/@Rating"/> </br>
	<strong>Description:</strong> </br>
	<x:if select="$output/Item/Description">
	<x:out select="$output/Item/Description" />
	</x:if>

	<div style="width:100%; height:80%%;">

	<div id="map_canvas" style="width: 80%; height: 100%; margin: auto;" >
	</div> 

	</c:when>

	<c:otherwise>
		<h1>The page you are looking for is NOT FOUND</h1>
	</c:otherwise>
</c:choose>

</body>
</html>