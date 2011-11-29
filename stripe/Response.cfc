component accessors="true"
{
	property name="status";			//unprocessed, success, failure
	property name="result";			//the deserialized json object from the API call	
	property name="errorType";
	property name="errorMessage";
	property name="rawResponse";	//cfhttp.filecontent of the API http request	
		
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
