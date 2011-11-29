
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.retrieveInvoice(id=rc.id);
		
		invoiceItems = stripeResponse.getResult().lines["invoiceitems"];
		subscriptions = stripeResponse.getResult().lines["subscriptions"];
	}
</cfscript>

<h2>Retrieving Invoice</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		id: #stripeResponse.getResult().id#<br />
		subtotal: #stripeResponse.getResult().subtotal#<br /> 
		total: #stripeResponse.getResult().total#<br /> 
		<cfloop from="1" to="#arrayLen(invoiceItems)#" index="i">
			&nbsp;&nbsp;#invoiceItems[i].description#, #invoiceItems[i].amount#<br />
		</cfloop>
		<cfloop from="1" to="#arrayLen(subscriptions)#" index="i">
			&nbsp;&nbsp;#subscriptions[i].plan.name#, #subscriptions[i].amount#<br />
		</cfloop>
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('invoice.retrieve')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Invoice ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Retrieve Invoice" />
	</p>
</form>