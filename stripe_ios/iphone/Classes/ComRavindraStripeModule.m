/**
 * stripe_ios
 *
 * Created by Ravindra Chherke
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "ComRavindraStripeModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComRavindraStripeModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"676a4db3-0838-444c-833f-e3f3bce50b11";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.ravindra.stripe";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}




-(BOOL)setCard:(id)args
{
    
    NSString *cardNumber = nil;
    NSString *cvc = nil;
    int month = 0;
    int expiryYear = 0;
    
    NSLog(@"SetCard");
    
    // return YES;
    
    NSString *publishableKey = (NSString*)[args objectForKey:@"publishableKey"];
    if (publishableKey != nil) {
        [Stripe setDefaultPublishableKey:publishableKey];
    }else{
        return NO;
    }
    
    
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
    
    
    card = [[STPCard alloc] init];
    card.number = cardNumber;
    card.expMonth = month;
    card.expYear = expiryYear;
    card.cvc = cvc;
    
    NSLog(@"SetCard Done");
    
    return YES;
    
}


-(void)_destroy
{
    // Make sure to release the callback objects
    RELEASE_TO_NIL(successCallback);
    RELEASE_TO_NIL(failureCallback);
    
    
    [super _destroy];
}


-(void) requestForToken:(id)args {
    
    
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    
    NSLog(@"[KROLLDEMO] registerCallbacks called");
    
    // Save the callback functions and retain them
    successCallback = [[args objectForKey:@"success"] retain];
    failureCallback = [[args objectForKey:@"failure"] retain];
    
    //  [self _fireEventToListener:@"success" withObject:nil listener:successCallback thisObject:nil];
    
    NSError *temp_error=nil;
    BOOL validation = [card validateCardReturningError:&temp_error];
    
    
    if(validation)
    {
        
        [[STPAPIClient sharedClient] createTokenWithCard:card
                                              completion:^(STPToken *token, NSError *error) {
                                                  if (error) {
                                                      NSString *message=[error localizedDescription];
                                                      if (failureCallback != nil){
                                                          
                                                          NSMutableDictionary *event = [NSMutableDictionary dictionary];
                                                          [event setObject:message forKey:@"error"];
                                                          
                                                          // Fire an event directly to the specified listener (callback)
                                                          
                                                          [self _fireEventToListener:@"failure" withObject:event listener:failureCallback thisObject:nil];
                                                      }
                                                      
                                                      // [self handleError:error];
                                                  } else {
                                                      
                                                      NSString *message=token.tokenId;
                                                      if (successCallback != nil){
                                                          
                                                          NSMutableDictionary *event = [NSMutableDictionary dictionary];
                                                          [event setObject:message forKey:@"token"];
                                                          
                                                          // Fire an event directly to the specified listener (callback)
                                                          [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
                                                      }
                                                      //[self createBackendChargeWithToken:token];
                                                  }
                                              }];
        
        
    } else
    {
        
        //  [failureCallback call:<#(NSArray *)#> thisObject:<#(id)#>]
        
        NSString *message=[temp_error localizedDescription];
        if (failureCallback != nil){
            
            NSMutableDictionary *event = [NSMutableDictionary dictionary];
            [event setObject:message forKey:@"error"];
            
            // Fire an event directly to the specified listener (callback)
            [self _fireEventToListener:@"failure" withObject:event listener:failureCallback thisObject:nil];
        }
        
    }
    
}

@end
