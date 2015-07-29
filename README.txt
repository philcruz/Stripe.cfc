
** Stripe.cfc was rolled into CFPAYMENT (https://github.com/ghidinelli/cfpayment) and is not being actively maintained. **


Stripe.cfc is a ColdFusion api binding for http://stripe.com.

This project is a complete web application and expects to live in its own webroot. To use Stripe.cfc
in your own web application, you can copy the stripe folder to your webroot or create a mapping to it.
Basic usage is like:

    stripe = createObject("component", "stripe.Stripe").init(secretKey=application.stripeSecretKey);										
    money = stripe.createMoney(rc.amount*100);					
    stripeResponse = stripe.createCharge(money=money,card=rc.stripeToken,description="testing with the Stripe.cfc");
    			
	//check the response and handle it as needed
	if (stripeResponse.getSuccess())
	{
		//handle the success, you may want to update the database and redirect to a confirmation
		id = stripeResponse.getResult().id; //get the id of the transaction out of the response
	}
	else
	{
		//handle the failure, you may want to send a notification email or log it										
	}

Implements all the functions of the Stripe API:
Charges, Customers, Plans, Coupons, Subscriptions, Invoice Items, Invoices, and Tokens

Supported CFML engines: ColdFusion 9.0.1 or Railo 3.3.1

Support: http://groups.google.com/group/stripecfc/
	
FW/1 (https://github.com/seancorfield/fw1) is the framework used for this web application
but that is not required to use Stripe.cfc in your own application. 			


Changes:
12/15/2011 - 1.0.4, add missing optional parameters for createCustomer()
12/01/2011 - 1.0.3, add Card.cfc, add support for functions that optionally take a Card object, i.e. createCustomer()
			 update methods that take ammount/currency to take Money object, to be consist with createCharge() 
11/29/2011 - 1.0.2,Response.errorCode
11/29/2011 - 1.0.1,changes to Response.getRawResponse() to .getResult(), use a common view for errors, handle 400,404 status codes			