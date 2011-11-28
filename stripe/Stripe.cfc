component accessors="true"
{
	property name="secretKey";			//Stripe secret key
	property name="gatewayBaseUrl";		//API url, i.e. https://api.stripe.com/v1/
	
	function init(string gatewayBaseUrl="https://api.stripe.com/v1/", string secretKey="")
	{
		setSecretKey(arguments.secretKey);
		setGatewayBaseUrl(arguments.gatewayBaseUrl);
		return this;
	}
	
	function getVersion()
	{
		return "1.0.0";
	}
	
	function updateSubscription(id,plan,prorate=true,trial_end="",card="")
	{
		var gateway = variables.gatewayBaseUrl & "customers/" & trim(arguments.id) & "/subscription";
		var payload = structNew();
		payload.plan = arguments.plan;
		payload.prorate = arguments.prorate;		
		return process(gatewayUrl=gateway, payload = payload, method="post");		
	}
	
	function cancelSubscription(id,plan,at_period_end=false)
	{
		var gateway = variables.gatewayBaseUrl & "customers/" & trim(arguments.id) & "/subscription";
		var payload = structNew();
		payload.at_period_end= arguments.at_period_end;
		return process(gatewayUrl=gateway, payload = payload, method="delete");		
	}
	
	function retrieveInvoice(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "invoices/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function retrieveUpcomingInvoice(required string customer)
	{
		var gateway = variables.gatewayBaseUrl & "invoices/upcoming?customer=" & trim(arguments.customer);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function listInvoices( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "invoices?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createInvoiceItem(customer,amount,currency,description)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems";
		var payload = structNew();					
		payload.customer = arguments.customer;
		payload.amount = arguments.amount;
		payload.currency = arguments.currency;
		payload.description = arguments.description;
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function updateInvoiceItem(id,amount,currency="usd",description)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems/" & arguments.id;
		var payload = structNew();					
		payload.amount = arguments.amount;
		payload.currency = arguments.currency;
		payload.description = arguments.description;
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrieveInvoiceItem(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function deleteInvoiceItem(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems/" & trim(arguments.id);
		var payload = structNew();				
		return process(gatewayUrl=gateway, payload = payload, method="delete");
	}
	
	function listInvoiceItems( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createCoupon(id,percent_off,duration,duration_in_months="",max_redemptions="",redeem_by="")
	{
		var gateway = variables.gatewayBaseUrl & "coupons";
		var payload = structNew();					
		payload.id = arguments.id;
		payload.percent_off= arguments.percent_off;
		payload.duration = arguments.duration;
		if (len(trim(arguments.duration_in_months))) payload.duration_in_months = arguments.duration_in_months;
		if (len(trim(arguments.max_redemptions))) payload.max_redemptions = arguments.max_redemptions;
		if (len(trim(arguments.redeem_by))) payload.redeem_by =  dateToUTC(arguments.redeem_by);
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrieveCoupon(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "coupons/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function deleteCoupon(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "coupons/" & trim(arguments.id);
		var payload = structNew();				
		return process(gatewayUrl=gateway, payload = payload, method="delete");
	}
	
	function listCoupons( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "coupons?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createPlan(id,amount,currency,interval,name,trial_period_days)
	{
		var gateway = variables.gatewayBaseUrl & "plans";
		var payload = structNew();					
		payload.id = arguments.id;
		payload.amount = arguments.amount;
		payload.currency = arguments.currency;
		payload.interval = arguments.interval;
		payload.name = arguments.name;
		payload.trial_period_days = arguments.trial_period_days;
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrievePlan(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "plans/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function deletePlan(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "plans/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="delete");
	}
	
	function listPlans( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "plans?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createCustomer(required string card,required string email, string description="")
	{
		var gateway = variables.gatewayBaseUrl & "customers";
		var payload = structNew();					
		payload.card = arguments.card;
		payload.email = arguments.email;
		payload.description = arguments.description;		
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrieveCustomer(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "customers/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function updateCustomer(required string id, string email, string description)
	{
		var gateway = variables.gatewayBaseUrl & "customers/" & trim(arguments.id);
		var payload = structNew();
		payload.email = arguments.email;
		payload.description = arguments.description;		
		return process(gatewayUrl=gateway, payload = payload, method="post");
	}
	
	function listCustomers( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "customers?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createCharge(required money,required string card,string description="")
	{
		var gateway = variables.gatewayBaseUrl & "charges";
		var payload = structNew();	
		payload.amount = arguments.money.getCents();
		payload.currency = arguments.money.getCurrency();
		payload.card = arguments.card;
		payload.description = arguments.description;		
				
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrieveCharge(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "charges/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function refundCharge(required string id, numeric amount)
	{
		var gateway = variables.gatewayBaseUrl & "charges/" & trim(arguments.id) & "/refund";
		var payload = structNew();
		payload.amount = arguments.amount;
		return process(gatewayUrl=gateway, payload = payload, method="post");
	}
	
	function listCharges( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "charges?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createToken(required string number,exp_month,exp_year,cvc,name="",address_line1="", address_line2="", address_zip="",address_state="",address_country="",amount="",currency="usd")
	{
		var gateway = variables.gatewayBaseUrl & "tokens";
		var payload = structNew();					
		payload["card[number]"] = arguments.number;
		payload["card[exp_month]"] = arguments.exp_month;
		payload["card[exp_year]"] = arguments.exp_year;
		payload["card[cvc]"] = arguments.cvc;		
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function retrieveToken(required string id)
	{
		var gateway = variables.gatewayBaseUrl & "tokens/" & trim(arguments.id);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}

	// set up the http call and handle the response			
	function process(string gatewayUrl,struct payload, method="post")
	{		
		var stripeResponse = createObject("component", "stripe.Response").init();
		var httpResponse = doHttp(url=gatewayUrl, payload=arguments.payload, method=arguments.method);
		var status = reReplace(httpResponse.statusCode, "[^0-9]", "", "ALL");
		
		if (status NEQ "200")
		{
			stripeResponse.setErrorType("http_error");
			stripeResponse.setErrorMessage("Gateway returned unknown response: #status#: #httpResponse.errorDetail#");
			stripeResponse.setStatus("failure");
			stripeResponse.setRawResponse(httpResponse);
		}
		else
		{
			var response = deserializeJSON(httpResponse.fileContent);
		
			if (structKeyExists( response, "error" ))
			{	
				//failure
				stripeResponse.setStatus("failure");
				stripeResponse.setErrorType(response.error.type);
				stripeResponse.setErrorMessage(response.error.message);	
			} 
			else
			{
				// success					
				stripeResponse.setStatus("success");
				if (isDefined('response.ID')) stripeResponse.setID(response.ID);
				if (isDefined('response.object')) stripeResponse.setObject(response.object);			
			}
			stripeResponse.setRawResponse(response);	
		}
				
		return stripeResponse;
	}
	
	/*
	 * wrapper around the http call
	 */
	function doHttp(string url, struct payload, string method="post")
	{
		var httpService = new http(method=arguments.method, url=arguments.url, username="#variables.secretKey#", password=""); 		
		if (not structIsEmpty(arguments.payload))
		{
			var i = 0;
			var keys = structKeyArray(arguments.payload);
			for (i = 1; i LTE (arrayLen(keys)); i = i + 1)
			{	
				//note Stripe API wants parameter names in lower case
				//WriteLog(type="Information", file="stripe", text="#keys[i]#"); 
				httpService.addParam(type="formfield",name="#lcase(keys[i])#",value="#arguments.payload[keys[i]]#"); 
			}
		}		
		return httpService.send().getPrefix(); 							
	}
	
	//convert a date to UTC timestamp (epoch seconds)
	function dateToUTC(required date)
	{		
		return DateDiff("s", DateConvert("utc2Local", "January 1 1970 00:00"), arguments.date);
	}
	
	//convert a UTC timestamp (epoch seconds) to a date
	function UTCToDate(utcDate)
	{
		return DateAdd("s",arguments.utcDate,DateConvert("utc2Local", "January 1 1970 00:00"));
	}
}

