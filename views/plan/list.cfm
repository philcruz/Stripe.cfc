<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listPlans(count=rc.count);
	
	plans= stripeResponse.getResult().data;
</cfscript>

<h2>List Plans</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Name</th>
		<th></th>
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(plans)#" index="i">
	<tr>
		<td><a href="#buildUrl('plan.retrieve?id=#plans[i].id#')#">#plans[i].id#</a></td>		
		<td>#plans[i].name#</td>
		<td><a href="#buildUrl('plan.delete?id=#plans[i].id#')#">Delete</a></td>		
	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#plans# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />