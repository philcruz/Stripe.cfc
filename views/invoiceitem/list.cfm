<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listInvoiceItems(count=rc.count);
	
	invoiceItems = stripeResponse.getResult().data;
</cfscript>

<h2>List Invoice Items</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Description</th>
		<th>Amount</th>
		<th></th>
		<th></th>
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(invoiceItems)#" index="i">
	<tr>
		<td><a href="#buildUrl('invoiceItem.retrieve?id=#invoiceItems[i].id#')#">#invoiceItems[i].id#</a></td>		
		<td>#invoiceItems[i].description#</td>
		<td>#invoiceItems[i].amount#</td>
		<td><a href="#buildUrl('invoiceItem.update?id=#invoiceItems[i].id#')#">Update</a></td>		
		<td><a href="#buildUrl('invoiceItem.delete?id=#invoiceItems[i].id#')#">Delete</a></td>		
	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#invoiceItems# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />