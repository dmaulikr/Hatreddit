//
//  VWWRESTConfig.h
//  SmileModel
//
//  Created by Zakk Hoyt
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