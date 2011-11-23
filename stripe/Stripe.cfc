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

	// set up the http call and handle the response			
	function process(string gatewayUrl,struct payload, method="post")
	{		
		var httpResponse = doHttp(url=gatewayUrl, payload=arguments.payload, method=arguments.method);
		var response = deserializeJSON(httpResponse.fileContent);
		var stripeResponse = createObject("component", "stripe.Response").init();
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
			stripeResponse.setID(response.ID);
			stripeResponse.setObject(response.object);			
		}
		stripeResponse.setRawResponse(response);
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

