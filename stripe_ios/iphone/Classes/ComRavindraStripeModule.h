/**
 * stripe_ios
 *
 * Created by Ravindra Chherke
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <Stripe/Stripe.h>
@interface ComRavindraStripeModule : TiModule
{
    
    Stripe *stripe;
    STPCard *card;
    KrollCallback *successCallback;
    KrollCallback *failureCallback;
}

@end
