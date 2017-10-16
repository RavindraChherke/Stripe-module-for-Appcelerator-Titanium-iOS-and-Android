# Stripe module for Appcelerator Titanium iOS and Android

Stripe payment module for Titanium iOS and Android

Check [releases](https://github.com/RavindraChherke/Stripe-module-for-Appcelerator-Titanium-iOS-and-Android/releases)

#Example

```javascript
//require the module
var stripe = require('com.ravindra.stripe');

//set card information using setCard method

var value = stripe.setCard({
	publishableKey : "pk_test_6pRNASCoBOKtIshFeQd4XMUh",
	cardNumber:"4242424242424242",
	month : 12,
	expiryYear : 2019,
	cvc : "123"
});


//request for token from stripe 
stripe.requestForToken({
	success : success,
	failure : failure
});

//On successful receive of token
function success(e) {
	alert("Toke received from Stripe: " + e.token);
}

//On failure 
function failure(e) {
	alert("Error: " + e.error);
}
```

