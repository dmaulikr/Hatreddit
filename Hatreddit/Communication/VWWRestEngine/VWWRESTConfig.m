//
//  VWWRESTConfig.m
//  SmileModel
//
//  Created by Zakk hoyt
//  Copyright (c) 2013 Webshots. All rights reserved.
//

#import "VWWRESTConfig.h"

static NSString *kServer = @"www.reddit.com";

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
        _domain = kServer;
        //_endpoint = [NSString stringWithFormat:@"%@/", kServer];
        _userURI = @"user";
    }
    return self;
}
@end