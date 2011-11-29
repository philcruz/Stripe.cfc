
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	param name="rc.email" default="";
	param name="rc.description" default="";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.updateCustomer(id=rc.id,email=rc.email,description=rc.description);
	}
</cfscript>

<h2>Update Customer</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		description: #stripeResponse.getResult().description#<br />
		email: #stripeResponse.getResult().email#<br />
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('customer.update')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Customer ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Email:<br />
		<input type="text" name="email" value="<cfoutput>#htmlEditFormat( rc.email)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Description:<br />
		<input type="text" name="description" value="<cfoutput>#htmlEditFormat( rc.description)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Update Customer" />
	</p>
</form>