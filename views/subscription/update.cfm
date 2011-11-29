
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	param name="rc.plan" default="";
	param name="rc.coupon" default="";
	param name="rc.prorate" default="";
	param name="rc.trial_end" default="";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.updateSubscription(id=rc.id,plan=rc.plan);
	}
</cfscript>

<h2>Update Subscription</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		status: #stripeResponse.getResult().status#<br />		
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('subscription.update')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Customer ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Plan:<br />
		<input type="text" name="plan" value="<cfoutput>#htmlEditFormat( rc.plan)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Update Subscription" />
	</p>
</form>