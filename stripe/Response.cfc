component accessors="true"
{
	property name="status";			//unprocessed, success, failure
	property name="ID";
	property name="object";
	property name="liveMode";
	property name="rawResponse";	
	property name="errorType";
	property name="errorMessage";
		
	function init()
	{
		setStatus("unprocessed");
		setRawResponse("");
		setID("");
		setLiveMode(false);		
		return this;
	}
	
	function getSuccess()
	{
		return (lcase(getStatus()) EQ "success");
	}
	
	
}
