component accessors="true"
{
	property name="status";			//unprocessed, success, failure
	property name="result";			//the deserialized json object from the API call	
	property name="errorType";		//error types: invalid_request_error, api_error, card_error, http_error
	property name="errorCode";
	property name="errorMessage";
	property name="rawResponse";	//the raw response from the cfhttp request
		
	function init()
	{
		setStatus("unprocessed");
		setRawResponse("");
		setResult(StructNew());		
		return this;
	}
	
	function getSuccess()
	{
		return (lcase(getStatus()) EQ "success");
	}
	
	
}
