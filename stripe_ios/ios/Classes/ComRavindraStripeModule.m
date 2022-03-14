/**
 * stripe_ios
 *
 * Created by Your Name
 * Copyright (c) 2020 Your Company. All rights reserved.
 */

#import "ComRavindraStripeModule.h"
@import TitaniumKit;

@implementation ComRavindraStripeModule

#pragma mark Internal

- (id)moduleGUID
{
    return @"7c1b9991-2bbe-4f2d-b2d6-40daeea8bd33";
}

- (NSString *)moduleId
{
    return @"com.ravindra.stripe";
}

#pragma Public APIs

- (void)initialize:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    NSString *publishableKey=nil;
    if ([args objectForKey:@"publishableKey"]) {
        publishableKey = (NSString*)[args objectForKey:@"publishableKey"];
    }
    
    [STPAPIClient sharedClient].publishableKey = publishableKey;
    
    NSString *stripeAccount=nil;
    if ([args objectForKey:@"stripeAccount"]) {
        stripeAccount = (NSString*)[args objectForKey:@"stripeAccount"];
    }
     [STPAPIClient sharedClient].stripeAccount = stripeAccount;
}

-(void)createPaymentMethod:(id) args {
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSString* cardNumber = nil;
    int month = 1;
    int expiryYear = 2022;
    NSString* cvc = nil;
    KrollCallback *paymentMethodCallback;
    
    if ([args objectForKey:@"cardNumber"]) {
        cardNumber = (NSString*)[args objectForKey:@"cardNumber"];
    }
    
    if ([args objectForKey:@"cvc"]) {
        cvc = (NSString*)[args objectForKey:@"cvc"];
    }
    
    if ([args objectForKey:@"month"]) {
        id temp_month = [args objectForKey:@"month"];
        month=[TiUtils intValue:temp_month];
    }
    
    if ([args objectForKey:@"expiryYear"]) {
        id temp_expiryYear = [args objectForKey:@"expiryYear"];
        expiryYear=[TiUtils intValue:temp_expiryYear];
    }
    
    if ([args objectForKey:@"paymentMethodCallback"]) {
        paymentMethodCallback = [args objectForKey:@"paymentMethodCallback"];
    }
    
    STPPaymentMethodCardParams *cardParams=[[STPPaymentMethodCardParams alloc] init];
    cardParams.number = cardNumber;
    cardParams.expMonth = [NSNumber numberWithInt:month];
    cardParams.expYear =  [NSNumber numberWithInt:expiryYear];;
    cardParams.cvc = cvc;
    
    STPPaymentMethodParams *paymentMethodParams= [STPPaymentMethodParams paramsWithCard:cardParams billingDetails:nil metadata:nil];
    
    
    [[STPAPIClient sharedClient] createPaymentMethodWithParams:paymentMethodParams completion:^(STPPaymentMethod * _Nullable paymentMethod, NSError * _Nullable error) {
        
        NSMutableDictionary *event = [NSMutableDictionary dictionary];
        
        if([paymentMethod stripeId]!=nil){
            [event setObject:[paymentMethod stripeId] forKey:@"paymentMethodId"];
        }
        
        if([error localizedDescription]!=nil){
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        [self _fireEventToListener:@"paymentMethodCallback" withObject:event listener:paymentMethodCallback thisObject:nil];
    }];
};



-(void)confirmSetupIntent:(id) args {
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSString* clientSecret;
    NSString* paymentId ;
    NSString* stripeAccount;
    KrollCallback * confirmSetupIntentCallback;
    
    
    if ([args objectForKey:@"clientSecret"]) {
        clientSecret = (NSString*)[args objectForKey:@"clientSecret"];
    }
    
    if ([args objectForKey:@"paymentId"]) {
        paymentId = (NSString*)[args objectForKey:@"paymentId"];
    }
    
    if ([args objectForKey:@"stripeAccount"]) {
        stripeAccount = [args objectForKey:@"stripeAccount"];
    }
    
    if ([args objectForKey:@"confirmSetupIntentCallback"]) {
        confirmSetupIntentCallback = [args objectForKey:@"confirmSetupIntentCallback"];
    }
    
    STPSetupIntentConfirmParams *setupIntentParams=[[STPSetupIntentConfirmParams alloc] initWithClientSecret:clientSecret];
    setupIntentParams.paymentMethodID = paymentId;
    
    if (stripeAccount != nil) {
        [[STPPaymentHandler sharedHandler] apiClient].stripeAccount=stripeAccount;
    } else {
        [[STPPaymentHandler sharedHandler] apiClient].stripeAccount=nil;
    }
    
    [[STPPaymentHandler sharedHandler] confirmSetupIntent:setupIntentParams withAuthenticationContext:self completion:^(STPPaymentHandlerActionStatus status, STPSetupIntent * _Nullable setupIntent, NSError * _Nullable error) {
        
        NSMutableDictionary *event = [NSMutableDictionary dictionary];
        switch (status) {
            case 0:
                //STPPaymentHandlerActionStatusSucceeded:
                [self _fireEventToListener:@"confirmSetupIntentCallback" withObject:event listener:confirmSetupIntentCallback thisObject:nil];
                break;
            case 1:
                //STPPaymentHandlerActionStatusCanceled:
                [event setObject:@"Cancelled" forKey:@"error"];
                [self _fireEventToListener:@"confirmSetupIntentCallback" withObject:event listener:confirmSetupIntentCallback thisObject:nil];
                break;
            case 2:
                //STPPaymentHandlerActionStatusFailed:
                [event setObject:error.localizedDescription forKey:@"error"];
                [self _fireEventToListener:@"confirmSetupIntentCallback" withObject:event listener:confirmSetupIntentCallback thisObject:nil];
                break;
        }
    }];
}

-(UIViewController *)authenticationPresentingViewController{
    return [TiApp controller];
}


-(void)handleNextActionForPaymentIntentWithAuthentication:(id) args{
    
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    NSString* clientSecret;
    NSString* stripeAccount;
    KrollCallback * handleNextActionForPaymentIntentCallback;
    
    
    if ([args objectForKey:@"clientSecret"]) {
        clientSecret = (NSString*)[args objectForKey:@"clientSecret"];
    }
    
    if ([args objectForKey:@"stripeAccount"]) {
        stripeAccount = [args objectForKey:@"stripeAccount"];
    }
    
    if ([args objectForKey:@"handleNextActionForPaymentIntentCallback"]) {
        handleNextActionForPaymentIntentCallback = [args objectForKey:@"handleNextActionForPaymentIntentCallback"];
    }
    
    if (stripeAccount != nil) {
        [[STPPaymentHandler sharedHandler] apiClient].stripeAccount=stripeAccount;
    } else {
        [[STPPaymentHandler sharedHandler] apiClient].stripeAccount=nil;
    }
    
    [[STPPaymentHandler sharedHandler] handleNextActionForPayment:clientSecret withAuthenticationContext:self returnURL:nil completion:^(STPPaymentHandlerActionStatus status, STPPaymentIntent * _Nullable handledIntent, NSError * _Nullable handlerError) {
        
        NSMutableDictionary *event = [NSMutableDictionary dictionary];
        
        switch (status) {
            case 0:
                //STPPaymentHandlerActionStatusSucceeded:
                [event setObject:[NSString stringWithFormat:@"%li",(long)status]forKey:@"status"];
                [event setObject:handledIntent.stripeId forKey:@"pid"];
                [event setObject:[NSNull null] forKey:@"error"];
                [self _fireEventToListener:@"handleNextActionForPaymentIntentCallback" withObject:event listener:handleNextActionForPaymentIntentCallback thisObject:nil];
                break;
            case 1:
                //STPPaymentHandlerActionStatusCanceled:
                [event setObject:[NSString stringWithFormat:@"%li",(long)status]forKey:@"status"];
                [event setObject:@"Cancelled" forKey:@"error"];
                [self _fireEventToListener:@"handleNextActionForPaymentIntentCallback" withObject:event listener:handleNextActionForPaymentIntentCallback thisObject:nil];
                break;
            case 2:
                //STPPaymentHandlerActionStatusFailed:
                [event setObject:[NSString stringWithFormat:@"%li",(long)status]forKey:@"status"];
                [event setObject:handlerError.localizedDescription forKey:@"error"];
                [self _fireEventToListener:@"handleNextActionForPaymentIntentCallback" withObject:event listener:handleNextActionForPaymentIntentCallback thisObject:nil];
                break;
        }
    }];
}

@end
