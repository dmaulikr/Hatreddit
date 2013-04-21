//
//  VWWRESTEngine.h
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//


#import "MKNetworkEngine.h"
#import "VWWHTTPRedditForm.h"

@class VWWRedditAbout;

typedef void (^VWWBoolBlock)(BOOL success);
typedef void (^VWWEmptyBlock)(void);

typedef void (^VWWErrorBlock)(NSError *error, NSString *additionalInfo);
typedef void (^VWWStringBlock)(NSString *string);
typedef void (^VWWRedditAboutBlock)(VWWRedditAbout *about);


@interface VWWRESTEngine : MKNetworkEngine

+(VWWRESTEngine*)publicInstance;
+(VWWRESTEngine*)privateInstance;

-(MKNetworkOperation*)getAboutInfoUser:(NSString*)user
                             completionBlock:(VWWRedditAboutBlock)completionBlock
                                  errorBlock:(VWWErrorBlock)errorBlock;


-(MKNetworkOperation*)loginWithForm:(VWWHTTPRedditForm*)form
                    completionBlock:(VWWStringBlock)completionBlock
                         errorBlock:(VWWErrorBlock)errorBlock;

@end
