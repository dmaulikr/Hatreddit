//
//  VWWRESTConfig.m
//  SmileModel
//
//  Created by Zakk hoyt
//  Copyright (c) 2013 Webshots. All rights reserved.
//

#import "VWWRESTConfig.h"

static NSString *kPublicServer = @"www.reddit.com";
static NSString *kPrivateServer = @"ssl.reddit.com";

@interface VWWRESTConfig ()

@end

@implementation VWWRESTConfig
+(VWWRESTConfig*)sharedInstance{
    static VWWRESTConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWRESTConfig alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        _publicDomain = kPublicServer;
        _publicEndpoint = [NSString stringWithFormat:@"%@/api", kPublicServer];
        _privateDomain = kPrivateServer;
        _privateEndpoint = [NSString stringWithFormat:@"%@/api", kPrivateServer];

        _loginURI = @"login";
        _userURI = @"user";
    }
    return self;
}
@end