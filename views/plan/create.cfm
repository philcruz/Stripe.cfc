
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	param name="rc.amount" default="100";
	param name="rc.currency" default="usd";
	param name="rc.interval" default="month";
	param name="rc.name" default="";
	param name="rc.trial_period_days" default="30";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.createPlan(id=rc.id,amount=rc.amount,currency=rc.currency,interval=rc.interval,name=rc.name,trial_period_days=rc.trial_period_days);
	}
</cfscript>

<h2>Create Plan</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		name: #stripeResponse.getRawResponse().name#<br />		
	<cfelse>
		errorType: #stripeResponse.getErrorType()#<br />
		errorMessage: #stripeResponse.getErrorMessage()#<br />
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('plan.create')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Name:<br />
		<input type="text" name="name" value="<cfoutput>#htmlEditFormat( rc.name)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Amount:<br />
		<input type="text" name="amount" value="<cfoutput>#htmlEditFormat( rc.amount)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Currency:<br />
		<input type="text" name="currency" value="<cfoutput>#htmlEditFormat( rc.currency)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Interval:<br />
		<input type="text" name="interval" value="<cfoutput>#htmlEditFormat( rc.interval)#</cfoutput>" size="20" />
	</p>	
	
	<p>
		Trial Period Days:<br />
		<input type="text" name="trial_period_days" value="<cfoutput>#htmlEditFormat( rc.trial_period_days)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Create Plan" />
	</p>
</form>