
<cfscript>
	param name="rc.customer" default="";
	param name="rc.isFormSubmitted" default="no";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.retrieveUpcomingInvoice(customer=rc.customer);
		subscriptions = ArrayNew(1);
		lines = stripeResponse.getResult().lines;
		if (isDefined('lines.subscriptions'))
			subscriptions = stripeResponse.getResult().lines["subscriptions"];		
	}
</cfscript>

<h2>Retrieving Upcoming Invoice</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		customer: #stripeResponse.getResult().customer#<br />
		subtotal: #stripeResponse.getResult().subtotal#<br /> 
		total: #stripeResponse.getResult().total#<br /> 
		<cfloop from="1" to="#arrayLen(subscriptions)#" index="i">
			&nbsp;&nbsp;#subscriptions[i].plan.id#,#subscriptions[i].plan.name#, #subscriptions[i].amount#<br />
		</cfloop> 
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('invoice.retrieveupcoming')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		Customer ID:<br />
		<input type="text" name="customer" value="<cfoutput>#htmlEditFormat( rc.customer)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Retrieve Upcoming Invoice" />
	</p>
</form>