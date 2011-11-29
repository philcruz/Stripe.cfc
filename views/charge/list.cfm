<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listCharges(count=rc.count);
	
	charges = stripeResponse.getResult().data;
</cfscript>

<h2>List Charges</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Amount</th>
		<th>Created</th>
		<th>Refunded</th>
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(charges)#" index="i">
	<tr>
		<td><a href="#buildUrl('charge.retrieve?id=#charges[i].id#')#">#charges[i].id#</a></td>
		<td>#dollarFormat(charges[i].amount/100)#</td>
		<td>#dateFormat(stripe.UTCToDate(charges[i].created),'mm-dd-yyyy')# </td>
		<td>#charges[i].refunded#</td>
		<td><a href="#buildUrl('charge.refund?id=#charges[i].id#&amount=#charges[i].amount#')#">Refund</a></td>
	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#charges# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />