/**
 * stripe_ios
 *
 * Created by Your Name
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <Stripe/Stripe.h>

@interface ComRavindraStripeModule : TiModule<STPAuthenticationContext>{

}

-(void)initialize:(id)args;
-(void)createPaymentMethod:(id) args;
-(void)confirmSetupIntent:(id) args;
-(void)handleNextActionForPaymentIntentWithAuthentication:(id) args;

@end
