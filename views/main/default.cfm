<cfscript>
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
</cfscript>

<div>
	Stripe.cfc is a ColdFusion api binding for http://stripe.com.
</div>
<br />
<strong>Charges</strong>
<ul>
	<li><a href="<cfoutput>#buildUrl('charge.create')#</cfoutput>" >Create a Charge</a></li>
	<li><a href="<cfoutput>#buildUrl('charge.retrieve')#</cfoutput>" >Retrieve a Charge</a></li>
	<li><a href="<cfoutput>#buildUrl('charge.refund')#</cfoutput>" >Refund a Charge</a></li>
	<li><a href="<cfoutput>#buildUrl('charge.list')#</cfoutput>" >List Charges</a></li>
</ul>
<br /><br />
<strong>Customers</strong>
<ul>
	<li><a href="<cfoutput>#buildUrl('customer.create')#</cfoutput>" >Create a Customer</a></li>
	<li><a href="<cfoutput>#buildUrl('customer.retrieve')#</cfoutput>" >Retrieve a Customer</a></li>
	<li><a href="<cfoutput>#buildUrl('customer.update')#</cfoutput>" >Update a Customer</a></li>
	<li><a href="<cfoutput>#buildUrl('customer.list')#</cfoutput>" >List Customers</a></li>
</ul>
<br /><br />
<strong>Plans</strong>
<ul>
	<li><a href="<cfoutput>#buildUrl('plan.create')#</cfoutput>" >Create a Plan</a></li>
	<li><a href="<cfoutput>#buildUrl('plan.retrieve')#</cfoutput>" >Retrieve a Plan</a></li>
	<li><a href="<cfoutput>#buildUrl('plan.delete')#</cfoutput>" >Delete Plan</a></li>
	<li><a href="<cfoutput>#buildUrl('plan.list')#</cfoutput>" >List Plans</a></li>
</ul>
<br /><br />
<strong>Coupons</strong>
<ul>
	<li><a href="<cfoutput>#buildUrl('coupon.create')#</cfoutput>" >Create a Coupon</a></li>
	<li><a href="<cfoutput>#buildUrl('coupon.retrieve')#</cfoutput>" >Retrieve a Coupon</a></li>
	<li><a href="<cfoutput>#buildUrl('coupon.delete')#</cfoutput>" >Delete Coupon</a></li>
	<li><a href="<cfoutput>#buildUrl('coupon.list')#</cfoutput>" >List Coupons</a></li>
</ul>
<br /><br />
Version: <cfoutput>#stripe.getVersion()#</cfoutput>


