
<cfscript>
	param name="rc.isFormSubmitted" default="no";
	param name="rc.number" default="4242424242424242";

	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);
		card = stripe.createCard(number=rc.number,exp_month=rc.exp_month,exp_year=rc.exp_year,cvc=rc.cvc);
		if (len(rc.amount))
		{
			money = createObject("component", "stripe.Money").init().setCents(rc.amount*100).setCurrency("usd");
			stripeResponse = stripe.createToken(card,money);
		}
		else
		{
			stripeResponse = stripe.createToken(card);				
		}		
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
		Amount: (in $USD)<br />
		<input type="text" name="amount" size="5"  value="" /> (Optional)
	</p>
	
	<p>
		<input type="submit" value="Create Token" />
	</p>
</form>
</cfoutput>