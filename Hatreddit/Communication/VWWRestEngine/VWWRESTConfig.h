//
//  VWWRESTConfig.h
//  SmileModel
//
//  Created by Aleksandar Tosovic on 4/24/12.
//  Copyright (c) 2012 Webshots. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VWWRESTConfig : NSObject
@property (nonatomic, strong) NSString* publicDomain;
@property (nonatomic, strong) NSString* publicEndpoint;
@property (nonatomic, strong) NSString* privateDomain;
@property (nonatomic, strong) NSString* privateEndpoint;

@property (nonatomic, strong) NSString* loginURI;
@property (nonatomic, strong) NSString* userURI;

+(VWWRESTConfig*)sharedInstance;

@end