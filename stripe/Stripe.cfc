/*
	Copyright(c) 2011, Phil Cruz

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
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
		return "1.0.4";
	}
	
	function createMoney(required numeric cents, currency="usd")
	{
		return createObject("component", "Money").init(arguments.cents,arguments.currency);	
	}
	
	function createCard(required string number,required exp_month,required exp_year,cvc="",name="",address_line1="",address_line2="",address_zip="",address_state="",address_country="")
	{
		var card = createObject("component", "Card").init(argumentcollection=arguments);
		return card;	
	}
	function updateSubscription(id,plan,prorate=true,trial_end="",card="")
	{
		var gateway = variables.gatewayBaseUrl & "customers/" & trim(arguments.id) & "/subscription";
		var payload = structNew();
		payload.plan = arguments.plan;
		payload.prorate = arguments.prorate;
		if (isObject(arguments.card) or ( isSimpleValue(arguments.card) and len(arguments.card) ))
			payload.card = arguments.card;
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
	
	function createInvoiceItem(required customer,required Money money,required description)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems";
		var payload = structNew();					
		payload.customer = arguments.customer;
		payload.amount = arguments.money.getCents();
		payload.currency = arguments.money.getCurrency();
		payload.description = arguments.description;
						
		return process(gatewayUrl=gateway, payload = payload);
	}
	
	function updateInvoiceItem(required string id,required Money money,required string description)
	{
		var gateway = variables.gatewayBaseUrl & "invoiceitems/" & arguments.id;
		var payload = structNew();					
		payload.amount = arguments.money.getCents();
		payload.currency = arguments.money.getCurrency();		
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
	
	function createPlan(required string id,required Money money,required interval,required name,interval_count, trial_period_days)
	{
		var gateway = variables.gatewayBaseUrl & "plans";
		var payload = structNew();					
		payload.id = arguments.id;
		payload.amount = arguments.money.getCents();
		payload.currency = arguments.money.getCurrency();		
		payload.interval = arguments.interval;
		payload.name = arguments.name;
		if (isDefined('arguments.trial_period_days') and isNumeric(arguments.trial_period_days))
			payload.trial_period_days = arguments.trial_period_days;
			
		if (isDefined('arguments.interval_count') and isNumeric(arguments.interval_count))
			payload.interval_count = interval_count;
						
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
	
	/*
	*
	* @param card (optional) Can be a string token or a Card object
	*/
	function createCustomer(card, string coupon="", string email="", string description="", string plan="", trial_end="")
	{
		var gateway = variables.gatewayBaseUrl & "customers";
		var payload = structNew();				
		if (isDefined('arguments.card'))payload.card = arguments.card;
		if (len(arguments.coupon)) 		payload.coupon = arguments.coupon;
		if (len(arguments.email)) 		payload.email = arguments.email;
		if (len(arguments.description))	payload.description = arguments.description;
		if (len(arguments.plan))		payload.plan = arguments.plan;
		if (len(arguments.trial_end))	payload.trial_end = dateToUTC(arguments.trial_end);
						
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
	
	function createCharge(required money,required card,string description="")
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
	
	function createToken(required card,Money money)
	{
		var gateway = variables.gatewayBaseUrl & "tokens";
		var payload = structNew();					
		payload.card = arguments.card;
		if (isDefined('arguments.money'))
		{
			payload.amount = arguments.money.getCents();
			payload.currency = arguments.money.getCurrency();
		}

								
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
		var response = "";
		stripeResponse.setRawResponse(httpResponse);
		
		if (status NEQ "200")
		{
			switch(status)
			{
				case "400":
				case "401":
				case "402":
				case "404":
					response = deserializeJSON(httpResponse.fileContent);					
					stripeResponse.setErrorType(response.error.type);					
					stripeResponse.setErrorMessage(response.error.message);	
					if (isDefined('response.error.code')) stripeResponse.setErrorCode(response.error.code);
					break;
				default:
					stripeResponse.setErrorType("http_error");
					stripeResponse.setErrorMessage("Gateway returned unknown response: #status#: #httpResponse.errorDetail#");					
			}
			stripeResponse.setStatus("failure");
		}
		else
		{
			response = deserializeJSON(httpResponse.fileContent);
		
			if (structKeyExists( response, "error" ))
			{	
				//failure
				stripeResponse.setStatus("failure");
				stripeResponse.setErrorType(response.error.type);
				stripeResponse.setErrorCode(response.error.code);
				stripeResponse.setErrorMessage(response.error.message);	
			} 
			else
			{
				// success					
				stripeResponse.setStatus("success");
			}
			stripeResponse.setResult(response);	
		}
				
		return stripeResponse;
	}
	
	/*
	 * wrapper around the http call
	 */
	function doHttp(string url, struct payload, string method="post")
	{
		var httpService = new http(method=arguments.method, url=arguments.url, username=variables.secretKey, password=""); 		
		if (not structIsEmpty(arguments.payload))
		{
			var i = 0;
			var keys = structKeyArray(arguments.payload);
			for (i = 1; i LTE (arrayLen(keys)); i = i + 1)
			{	
				//note Stripe API wants parameter names in lower case
				//WriteLog(type="Information", file="stripe", text="#keys[i]#"); 
				if (lcase(keys[i]) NEQ "card" )
				{
					httpService.addParam(type="formfield",name="#lcase(keys[i])#",value=arguments.payload[keys[i]]);		
				}
				else
				{
					var card = arguments.payload["card"];
					if (isObject(card))
					{
						httpService.addParam(type="formfield",name="card[number]",value=card.getNumber());
						httpService.addParam(type="formfield",name="card[exp_month]",value=card.getExp_month());
						httpService.addParam(type="formfield",name="card[exp_year]",value=card.getExp_year());
						httpService.addParam(type="formfield",name="card[cvc]",value=card.getCvc());
						httpService.addParam(type="formfield",name="card[name]",value=card.getName());
						httpService.addParam(type="formfield",name="card[address_line1]",value=card.getAddress_line1());
						httpService.addParam(type="formfield",name="card[address_line2]",value=card.getAddress_line2());
						httpService.addParam(type="formfield",name="card[address_zip]",value=card.getAddress_zip());
						httpService.addParam(type="formfield",name="card[address_state]",value=card.getAddress_state());
						httpService.addParam(type="formfield",name="card[address_country]",value=card.getAddress_country());								
					}
					else
					{
						//must be a string token	
						httpService.addParam(type="formfield",name="card",value=card);
					}
				}				
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

