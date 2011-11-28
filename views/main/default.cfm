<cfscript>
	stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);												
</cfscript>

<div>
	Stripe.cfc is a ColdFusion api binding for http://stripe.com.
</div>
<br />

<table border="0" cellpadding="10" cellspacing="5">
	<tr>
		<td valign="top">					
			<strong>Charges</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('charge.create')#</cfoutput>" >Create a Charge</a></li>
				<li><a href="<cfoutput>#buildUrl('charge.retrieve')#</cfoutput>" >Retrieve a Charge</a></li>
				<li><a href="<cfoutput>#buildUrl('charge.refund')#</cfoutput>" >Refund a Charge</a></li>
				<li><a href="<cfoutput>#buildUrl('charge.list')#</cfoutput>" >List Charges</a></li>
			</ul>
		</td>
		<td valign="top">
			<strong>Subscriptions</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('subscription.update')#</cfoutput>" >Update Subscription</a></li>
				<li><a href="<cfoutput>#buildUrl('subscription.cancel')#</cfoutput>" >Cancel Subscription</a></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>
			<strong>Customers</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('customer.create')#</cfoutput>" >Create a Customer</a></li>
				<li><a href="<cfoutput>#buildUrl('customer.retrieve')#</cfoutput>" >Retrieve a Customer</a></li>
				<li><a href="<cfoutput>#buildUrl('customer.update')#</cfoutput>" >Update a Customer</a></li>
				<li><a href="<cfoutput>#buildUrl('customer.list')#</cfoutput>" >List Customers</a></li>
			</ul>
		</td>
		<td valign="top">
			<strong>Invoices</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('invoice.retrieve')#</cfoutput>" >Retrieve an Invoice</a></li>
				<li><a href="<cfoutput>#buildUrl('invoice.retrieveupcoming')#</cfoutput>" >Retrieve an Upcoming Invoice</a></li>
				<li><a href="<cfoutput>#buildUrl('invoice.list')#</cfoutput>" >List Invoices</a></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<strong>Plans</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('plan.create')#</cfoutput>" >Create a Plan</a></li>
				<li><a href="<cfoutput>#buildUrl('plan.retrieve')#</cfoutput>" >Retrieve a Plan</a></li>
				<li><a href="<cfoutput>#buildUrl('plan.delete')#</cfoutput>" >Delete Plan</a></li>
				<li><a href="<cfoutput>#buildUrl('plan.list')#</cfoutput>" >List Plans</a></li>
			</ul>
		</td>
		<td valign="top">
			<strong>Invoice Items</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('invoiceitem.create')#</cfoutput>" >Create Invoice Item</a></li>	
				<li><a href="<cfoutput>#buildUrl('invoiceitem.retrieve')#</cfoutput>" >Retrieve Invoice Item</a></li>	
				<li><a href="<cfoutput>#buildUrl('invoiceitem.update')#</cfoutput>" >Update Invoice Item</a></li>	
				<li><a href="<cfoutput>#buildUrl('invoiceitem.delete')#</cfoutput>" >Delete Invoice Item</a></li>	
				<li><a href="<cfoutput>#buildUrl('invoiceitem.list')#</cfoutput>" >List Invoice Items</a></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<strong>Coupons</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('coupon.create')#</cfoutput>" >Create a Coupon</a></li>
				<li><a href="<cfoutput>#buildUrl('coupon.retrieve')#</cfoutput>" >Retrieve a Coupon</a></li>
				<li><a href="<cfoutput>#buildUrl('coupon.delete')#</cfoutput>" >Delete Coupon</a></li>
				<li><a href="<cfoutput>#buildUrl('coupon.list')#</cfoutput>" >List Coupons</a></li>
			</ul>
		</td>
		<td valign="top">
			<strong>Tokens</strong>
			<ul>
				<li><a href="<cfoutput>#buildUrl('token.create')#</cfoutput>" >Create Token</a></li>	
				<li><a href="<cfoutput>#buildUrl('token.retrieve')#</cfoutput>" >Retrieve Token</a></li>	
			</ul>
		</td>
	</tr>
</table>
<br />
Version: <cfoutput>#stripe.getVersion()#</cfoutput>


