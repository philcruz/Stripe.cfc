
<cfscript>
	param name="rc.customer" default="";
	param name="rc.isFormSubmitted" default="no";
	param name="rc.amount" default="100";
	param name="rc.currency" default="usd";
	param name="rc.description" default="";

	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.createInvoiceItem(customer=rc.customer,amount=rc.amount,currency=rc.currency,description=rc.description);
	}
</cfscript>

<h2>Create Invoice Item</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		description: #stripeResponse.getResult().description#<br />		
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('invoiceitem.create')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Customer ID:<br />
		<input type="text" name="customer" value="<cfoutput>#htmlEditFormat( rc.customer)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Description:<br />
		<input type="text" name="description" value="<cfoutput>#htmlEditFormat( rc.description)#</cfoutput>" size="20" />
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
		<input type="submit" value="Create Invoice Item" />
	</p>
</form>