
##  Stripe module for Appcelerator Titanium 

## There are breaking changes in version 2.0


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
