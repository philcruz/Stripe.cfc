
<cfscript>
	param name="rc.id" default="";
	param name="rc.isFormSubmitted" default="no";
	param name="rc.percent_off" default="10";
	param name="rc.duration" default="forever";
	param name="rc.duration_in_months" default="";
	param name="rc.max_redemptions" default="";
	param name="rc.redeem_by" default="";
	
	if (rc.isFormSubmitted EQ "yes")
	{
		stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
		stripeResponse = stripe.createCoupon(id=rc.id,percent_off=rc.percent_off,duration=rc.duration,duration_in_months=rc.duration_in_months,max_redemptions=rc.max_redemptions,redeem_by=rc.redeem_by);
	}
</cfscript>

<h2>Create Coupon</h2>

<cfoutput>
<cfif isDefined('stripeResponse')>
	<cfif stripeResponse.getSuccess()>
		ID: #stripeResponse.getResult().id#<br />		
		percent_off: #stripeResponse.getResult().percent_off#<br />		
	<cfelse>
		#view('common/responseerror')#
	</cfif>
	<br />
	<cfdump var=#stripeResponse# expand="no">	
</cfif>
</cfoutput>

<form action="<cfoutput>#buildUrl('coupon.create')#</cfoutput>" method="post">
	<input type="hidden" name="isFormSubmitted" value="yes" />
	<p>
		ID:<br />
		<input type="text" name="id" value="<cfoutput>#htmlEditFormat( rc.id)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Percent Off:<br />
		<input type="text" name="percent_off" value="<cfoutput>#htmlEditFormat( rc.percent_off)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Duration:<br />
		<input type="text" name="duration" value="<cfoutput>#htmlEditFormat( rc.duration)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Duration Months:<br />
		<input type="text" name="duration_in_months" value="<cfoutput>#htmlEditFormat( rc.duration_in_months)#</cfoutput>" size="20" />
	</p>
	
	<p>
		Max Redemptions:<br />
		<input type="text" name="max_redemptions" value="<cfoutput>#htmlEditFormat( rc.max_redemptions)#</cfoutput>" size="20" />
	</p>	
	
	<p>
		Redeem by:<br />
		<input type="text" name="redeem_by" value="<cfoutput>#htmlEditFormat( rc.redeem_by)#</cfoutput>" size="20" />
	</p>
	
	<p>
		<input type="submit" value="Create Coupon" />
	</p>
</form>