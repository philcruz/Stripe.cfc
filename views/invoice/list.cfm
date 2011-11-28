<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listInvoices(count=rc.count);
	
	invoices = stripeResponse.getRawResponse().data;
</cfscript>

<h2>List Invoices</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Amount</th>
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(invoices)#" index="i">
	<tr>
		<td><a href="#buildUrl('invoice.retrieve?id=#invoices[i].id#')#">#invoices[i].id#</a></td>		
		<td>#invoices[i].total#</td>
	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#invoices# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />