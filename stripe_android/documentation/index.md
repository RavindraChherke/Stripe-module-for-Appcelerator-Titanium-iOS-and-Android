# stripe_Android Module

## Description

This is a wrapper around the Stripe Android SDK It is used to send payment card details to the Stripe  and 
return a Single Use Token for use in your server-side.

You can create your own user interface and use this module for getting token from Stripe.



## Accessing the stripe_Android Module

To access this module from JavaScript, you would do the following:

    var stripe_Android = require("com.ravindra.stripe");

The stripe_Android variable is a reference to the Module object.

## Reference

Read more about using Stripe for payment from the following link

[Stripe Android Integration](https://stripe.com/docs/mobile/android)


## stripe_Android.function

###setCard
set card information using setCard method

###requestForToken
request for token from stripe 

## Usage

var stripe = require('com.ravindra.stripe');


var value = stripe.setCard({
	publishableKey : "<YOUR PUBLISHABLE KEY>",
	cardNumber:"4242424242424242",
	month : 12,
	expiryYear : 2016,
	cvc : "123"
});


 
stripe.requestForToken({
	success : success,
	failure : failure
});


function success(e) {
	alert("Toke received from Stripe: " + e.token);
}

 
function failure(e) {
	alert("Error: " + e.error);
}


## License

The MIT License

Copyright 2015 Ravindra Kumar Chherke

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.