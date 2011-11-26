
<cfscript>
	param name="rc.id" default="";
	param name="rc.amount" default="";
	param name="rc.isFormSubmitted" default="no";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.refundCharge(id=rc.id, amount=rc.amount);
		rawResponse = stripeResponse.getRawResponse();
	}
</cfscript>

<h2>Refund a Charge</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		<cfif isDefined('rawResponse.amount_refunded')>
		amount refunded: #dollarFormat(rawResponse.amount_refunded / 100)#<br /> 
		</cfif>
		amount: #dollarFormat(stripeResponse.getRawResponse().amount / 100)#<br />
	<cfelse>
		errorType: #stripeResponse.getErrorType()#<br />
		errorMessage: #stripeResponse.getErrorMessage()#<br />
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('charge.refund')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Charge ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Amount(cents):<br />
		<input type="text" name="amount" value="<cfoutput>#htmlEditFormat( rc.amount)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Refund Charge" />
	</p>
</form>