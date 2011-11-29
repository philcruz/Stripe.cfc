<cfscript>
	param name="rc.count" default="10";
	
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
	stripeResponse = stripe.listCoupons(count=rc.count);
	
	coupons = stripeResponse.getResult().data;
</cfscript>

<h2>List Coupons</h2>

<table cellpadding="5" cellspacing="5">
	<thead>
		<th>ID</th>
		<th>Percent Off</th>
		<th>Duration</th>
		<th>Redeem By</th>
		<th>Times Redeemed</th>
		<th>Max Redemptions</th>
		<th></th>		
	</thead>
<cfoutput>
<cfloop from="1" to="#arrayLen(coupons)#" index="i">
	<cfscript>
			if (structKeyExists(coupons[i],"duration_in_months"))			
				duration_in_months = coupons[i]["duration_in_months"];	
			else
				duration_in_months = "";
			if (structKeyExists(coupons[i],"redeem_by"))			
				 redeem_by = coupons[i]["redeem_by"];	
			else
				redeem_by = "";
			if (structKeyExists(coupons[i],"max_redemptions"))			
				 max_redemptions= coupons[i]["max_redemptions"];	
			else
				max_redemptions = "";
	</cfscript>
	<tr>
		<td><a href="#buildUrl('coupon.retrieve?id=#coupons[i].id#')#">#coupons[i].id#</a></td>		
		<td>#coupons[i].percent_off#</td>
		<td>#coupons[i].duration# <cfif len(duration_in_months)>(#duration_in_months# months)</cfif></td>
		<td><cfif len(redeem_by)> #dateFormat(stripe.UTCToDate(redeem_by), 'mm-dd-yyyy')#</cfif> </td>
		<td>#coupons[i].times_redeemed#</td>
		<td><cfif len(max_redemptions)> #max_redemptions#</cfif> </td>
		<td><a href="#buildUrl('coupon.delete?id=#coupons[i].id#')#">Delete</a></td>
	</tr>
</cfloop>
</cfoutput>
</table>

<cfdump var=#coupons# expand="no" />
<br />
<cfdump var=#stripeResponse# expand="no" />