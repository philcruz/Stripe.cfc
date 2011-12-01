component accessors="true"
{
	property name="number";
	property name="exp_month";
	property name="exp_year";
	property name="cvc";
	property name="name";
	property name="address_line1";
	property name="address_line2";
	property name="address_zip";
	property name="address_state";
	property name="address_country";
	
	function init(required string number,required exp_month,required exp_year,cvc="",name="",address_line1="",address_line2="",address_zip="",address_state="",address_country="")
	{
		setNumber(arguments.number);
		setExp_month(arguments.exp_month);
		setExp_year(arguments.exp_year);
		setCvc(arguments.cvc);
		setName(arguments.name);
		setAddress_line1(arguments.address_line1);
		setAddress_line2(arguments.address_line2);
		setAddress_zip(arguments.address_zip);
		setAddress_state(arguments.address_state);
		setAddress_country(arguments.address_country);
		return this;
	}						
}