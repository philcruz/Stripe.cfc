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
	
	function createCustomer(required string token,required string email, string description="")
	{
		var gateway = variables.gatewayBaseUrl & "customers";
		var payload = structNew();					
		payload.card = arguments.token;
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
	
	function listCustomers( numeric count=10)
	{
		var gateway = variables.gatewayBaseUrl & "customers?count=" & trim(arguments.count);
		var payload = structNew();
				
		return process(gatewayUrl=gateway, payload = payload, method="get");
	}
	
	function createCharge(required money,required string token,string description="")
	{
		var gateway = variables.gatewayBaseUrl & "charges";
		var payload = structNew();	
		payload.amount = arguments.money.getCents();
		payload.currency = arguments.money.getCurrency();
		payload.card = arguments.token;
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
}

