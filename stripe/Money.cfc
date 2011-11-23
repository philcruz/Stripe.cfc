component accessors="true"
{
	property name="cents";
	property name="currency";
	
	function init(numeric cents=0, string currency="usd")
	{
		setCents(arguments.cents);
		setCurrency(arguments.currency);
		return this;
	}			
	
	function setCents(cents)
	{
		variables.cents = arguments.cents;
		return this;	
	}
	
	function setCurrency(currency)
	{
		variables.currency = lcase(arguments.currency);
		return this;	
	}
}