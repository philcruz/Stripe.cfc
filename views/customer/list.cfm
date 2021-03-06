<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listCustomers(count=rc.count);
	
	customers = stripeResponse.getResult().data;
</cfscript>

<h2>List Customers</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Description</th>
		<th>Email</th>
		<th>Created</th>
		<th></th>
		<th></th>
		<th></th>
		<th></th>
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(customers)#" index="i">
	<tr>
		<td><a href="#buildUrl('customer.retrieve?id=#customers[i].id#')#">#customers[i].id#</a></td>
		<td>#customers[i].description#</td>
		<td>#customers[i].email#</td>
		<td>#customers[i].created#</td>
		<td><a href="#buildUrl('customer.update?id=#customers[i].id#')#">Update</a></td>
		<td><a href="#buildUrl('subscription.update?id=#customers[i].id#')#">Update Subscription</a></td>
		<td><a href="#buildUrl('subscription.cancel?id=#customers[i].id#')#">Cancel Subscription</a></td>
		<td><a href="#buildUrl('invoice.retrieveupcoming?customer=#customers[i].id#')#">Upcoming Invoice</a></td>

	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#customers# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />