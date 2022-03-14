/**
 * stripe_ios
 *
 * Created by Your Name
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

@import TitaniumKit;
@import Stripe;

@interface ComRavindraStripeModule : TiModule <STPAuthenticationContext>

-(void)initialize:(id)args;
-(void)createPaymentMethod:(id) args;
-(void)confirmSetupIntent:(id) args;
-(void)handleNextActionForPaymentIntentWithAuthentication:(id) args;

@end
