
<cfscript>
	
	param name="rc.isFormSubmitted" default="no";
	param name="rc.number" default="4242424242424242";
	param name="rc.amount" default="100";
	param name="rc.currency" default="usd";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.createToken(number=rc.number,exp_month=rc.exp_month,exp_year=rc.exp_year,cvc=rc.cvc);
	}
</cfscript>

<h2>Create Token</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		id: #stripeResponse.getResult().id#<br />		 
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>


<form action="<cfoutput>#buildUrl('token.create')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	 
	<p>
		Credit Card:<br />
		<input type="text" name="number" value="#rc.number#" size="20" class="creditCard" />
	</p>

	<p>
		Expiration:<br />
		<input type="text" size="5" name="exp_month" value="01" />
		<input type="text" size="5" name="exp_year" value="2013" />
		<em>(MM/YYYY)</em>
	</p>

	<p>
		Security Code:<br />
		<input type="text" name="cvc" size="5" class="securityCode" value="123" />
	</p>
	
	<p>
		<input type="submit" value="Create Token" />
	</p>
</form>
</cfoutput>