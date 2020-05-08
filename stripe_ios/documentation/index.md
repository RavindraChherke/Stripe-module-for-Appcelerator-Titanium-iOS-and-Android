

## Stripe payment module for Titanium iOS


## Adding Card

``` 
var paymentId = null;
var clientSecret = null;

var tiStripe = require('com.ravindra.stripe');

tiStripe.initialize({
    publishableKey:"XXXXXXX",
    stripeAccount:"XXXXXXXX" //(Optional)
})

tiStripe.createPaymentMethod({
    cardNumber: "XXXXXXXX",
    month: 2,
    expiryYear: 2020,
    cvc: "123",
    paymentMethodCallback: function (e) {
        if (e.error) {
            Ti.API.info('paymentMethodCallback:  Error: ' + e.error);
        } else {
            Ti.API.info('paymentMethodCallback:  paymentMethodId :' + e.paymentMethodId);
            paymentId = e.paymentMethodId;
            //Use Setup Intent API on server https://stripe.com/docs/payments/setup-intents. It will give you client secret
        }
    }
});


tiStripe.confirmSetupIntent({
    paymentId: paymentId,
    clientSecret: clientSecret,
    confirmSetupIntentCallback: function (e) {
        Ti.API.info('Ti ti_stripe.confirmSetupIntent:  Error: ' + e.error + ' status ' + e.status + ' success: ' + e.success + '  requires_confirmation: ' + e.requires_confirmation);
        if (e.error) {
            //Handle error (Show alert etc.)
        } else {
            // Send paymentId to server 
        }
    }
});
```
##  Checkout process

###  Create Payment Intent

Send checkout data to server to Create Payment Intent https://stripe.com/docs/payments/payment-intents. It will give you client secret and optional stripe account. 

###  Confirm Payment Intent
```
ti_stripe.handleNextActionForPaymentIntentWithAuthentication({
    clientSecret: "XXXXXXXX",
    stripeAccount: "XXXXXXXX", //(Optional)
    handleNextActionForPaymentIntentCallback: function (e) {
        if (e.pid) {
            // Send request on server to confirm the Payment Intent           
        } else {
            Ti.API.info(e.error);
        }
    }
});



```

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
