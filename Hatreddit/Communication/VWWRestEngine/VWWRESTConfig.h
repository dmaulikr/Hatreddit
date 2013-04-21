//
//  VWWRESTConfig.h
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/24/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VWWRESTConfig : NSObject
@property (nonatomic, strong) NSString* domain;
@property (nonatomic, strong) NSString* endpoint;

@property (nonatomic, strong) NSString* userURI;

+(VWWRESTConfig*)sharedInstance;

@end