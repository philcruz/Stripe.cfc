<cfscript>
	param name="rc.title" default="Stripe.cfc";
</cfscript>

<!DOCTYPE html>
<html>
	<head>
		<title><cfoutput>#rc.title#</cfoutput></title>				
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script> 
		<script type="text/javascript" src="https://js.stripe.com/v1/"></script>		
		<link rel="stylesheet" href="/css/default.css" type="text/css"> 		
	</head>
	<body>		
		<a href="/">Home</a>
		<h1>Stripe.cfc</h1>
		<cfoutput>#body#</cfoutput>
	</body>
</html>