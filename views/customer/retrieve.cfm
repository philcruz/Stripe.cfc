
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.retrieveCustomer(id=rc.id);
	}
</cfscript>

<h2>Retrieving Customer</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		description: #stripeResponse.getRawResponse().description#<br />
		email: #stripeResponse.getRawResponse().email#<br />
	<cfelse>
		errorType: #stripeResponse.getErrorType()#<br />
		errorMessage: #stripeResponse.getErrorMessage()#<br />
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('customer.retrieve')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Customer ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Retrieve customer" />
	</p>
</form>