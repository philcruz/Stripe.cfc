
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.deletePlan(id=rc.id);
	}
</cfscript>

<h2>Delete Plan</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		id: #stripeResponse.getRawResponse().id#<br />
		deleted: #stripeResponse.getRawResponse().deleted#<br />
	<cfelse>
		errorType: #stripeResponse.getErrorType()#<br />
		errorMessage: #stripeResponse.getErrorMessage()#<br />
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('plan.delete')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Plan ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Delete Plan" />
	</p>
</form>