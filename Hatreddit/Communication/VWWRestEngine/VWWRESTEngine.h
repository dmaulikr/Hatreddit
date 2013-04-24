//
//  VWWRESTEngine.h
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//
//  Reddit API: http://www.reddit.com/dev/api#GET_api_me.json


#import "MKNetworkEngine.h"
#import "VWWHTTPRedditForm.h"

@class VWWRedditAbout;
@class VWWRedditLogin;

typedef void (^VWWBoolBlock)(BOOL success);
typedef void (^VWWEmptyBlock)(void);

typedef void (^VWWErrorBlock)(NSString* errorDescription);
typedef void (^VWWStringBlock)(NSString *string);
typedef void (^VWWRedditAboutBlock)(VWWRedditAbout *about);
typedef void (^VWWRedditLoginBlock)(VWWRedditLogin *login);


@interface VWWRESTEngine : MKNetworkEngine

+(VWWRESTEngine*)publicInstance;
+(VWWRESTEngine*)privateInstance;

-(MKNetworkOperation*)getPublicInfoAboutUser:(NSString*)user
                             completionBlock:(VWWRedditAboutBlock)completionBlock
                                  errorBlock:(VWWErrorBlock)errorBlock;


-(MKNetworkOperation*)loginWithForm:(VWWHTTPRedditForm*)form
                    completionBlock:(VWWRedditLoginBlock)completionBlock
                         errorBlock:(VWWErrorBlock)errorBlock;

-(MKNetworkOperation*)meWithForm:(VWWHTTPRedditForm*)form
                    completionBlock:(VWWStringBlock)completionBlock
                         errorBlock:(VWWErrorBlock)errorBlock;


@end
