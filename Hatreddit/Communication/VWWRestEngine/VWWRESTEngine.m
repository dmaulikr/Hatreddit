//
//  SmileEngine.m
//  JSON
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//
//  Reddit API rules: https://github.com/reddit/reddit/wiki/API

#import "VWWRESTEngine.h"
#import "VWWRESTConfig.h"
#import "VWWRedditAbout.h"
#import "VWWRedditLogin.h"
#import "VWWRESTParser.h"

#define SM_LOG_CURL_COMMANDS 1

static NSString* kHTTPTRequstTypePost = @"POST";
static NSString* kHTTPTRequstTypeGet = @"GET";
static NSString* kHTTPTRequstTypePut = @"PUT";
static NSString* kHTTPTRequstTypeDelete = @"DELETE";

typedef void (^PSEErrorBlock)(NSError* error, id responseJSON);
typedef void (^PSESuccessBlock)(id responseJSON);

@interface VWWRESTEngine ()
@property (nonatomic, strong) VWWRESTConfig* config;
@property (nonatomic) BOOL secure;
@end

@implementation VWWRESTEngine

#pragma mark Overrides MKNetworkEngine

+(VWWRESTEngine*)publicInstance{
    static VWWRESTEngine *publicInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicInstance = [[VWWRESTEngine alloc]initForPublic:YES];
    });
 
    return publicInstance;
}
+(VWWRESTEngine*)privateInstance{
    static VWWRESTEngine *privateInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        privateInstance = [[VWWRESTEngine alloc]initForPublic:NO];
    });
    return privateInstance;
}

-(id)initForPublic:(BOOL)public{
    if(self){
        NSDictionary *headers = @{@"User-Agent":@"Objective-c Reddit engine by /u/sneeden"};
        if(public){
            //http://www.reddit.com/user/sneeden/about.json
            self.secure = NO;
            self.config = [VWWRESTConfig sharedInstance];
            self = [super initWithHostName:self.config.publicDomain
                                   apiPath:nil
                        customHeaderFields:headers];
        }
        else{
            //https://ssl.reddit.com/api/login
            self.secure = YES;
            self.config = [VWWRESTConfig sharedInstance];
            self = [super initWithHostName:self.config.privateEndpoint
                                   apiPath:nil
                        customHeaderFields:headers];
//            User-Agent: super happy flair bot v1.0 by /u/spladug
        }
    }
    return self;
}

-(void)prepareHeaders:(MKNetworkOperation *)operation {
//    // Read stored token from keychain system
//    SMCredential *credential = [[SMKeychain sharedKeychain] credentialForItemWithID:kSmileTokenKeychainItemID];
//    if ([credential.password length]) {
//        NSDictionary* headersDict = @{@"X-Auth-Token": credential.password};
//        [operation addHeaders:headersDict];
//    }

    [super prepareHeaders:operation];
}

#pragma mark Private custom methods
-(MKNetworkOperation*) httpGetEndpoint:(NSString*)endpoint
                        jsonDictionary:(NSDictionary*)jsonDictionary
                       completionBlock:(PSESuccessBlock)completionBlock
                            errorBlock:(PSEErrorBlock)errorBlock{
    
    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypeGet
                                                        ssl:self.secure];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Success! curlString=%@", completedOperation.curlCommandLineString);
#endif
        [completedOperation responseJSONWithOptions:NSJSONReadingAllowFragments
                                  completionHandler:^(id jsonObject) {
                                      completionBlock(jsonObject);
                                  }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Error! curlString=%@", completedOperation.curlCommandLineString);
#endif

        [completedOperation responseJSONWithOptions:NSJSONReadingAllowFragments
                                  completionHandler:^(id jsonObject) {
                                      errorBlock(error, jsonObject);
                                  }];

    }];
    
    [self enqueueOperation:operation];
    return operation;
}


-(MKNetworkOperation*) httpPostEndpoint:(NSString*)endpoint
                         jsonDictionary:(NSDictionary*)jsonDictionary
                         completionBlock:(PSESuccessBlock)completionBlock
                              errorBlock:(PSEErrorBlock)errorBlock{
    
    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypePost
                                                        ssl:self.secure];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Success! curlString=%@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
         NSLog(@"Error! curlString=%@", completedOperation.curlCommandLineString);
#endif
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}


-(MKNetworkOperation*) httpPutEndpoint:(NSString*)endpoint
                        jsonDictionary:(NSDictionary*)jsonDictionary
                        completionBlock:(PSESuccessBlock)completionBlock
                             errorBlock:(PSEErrorBlock)errorBlock{

    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:jsonDictionary
                                                 httpMethod:kHTTPTRequstTypePut
                                                        ssl:self.secure];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Success! curlString=%@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Error! curlString=%@", completedOperation.curlCommandLineString);
#endif
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
}

-(MKNetworkOperation*) httpDeleteEndpoint:(NSString*)endpoint
                       completionBlock:(PSESuccessBlock)completionBlock
                            errorBlock:(PSEErrorBlock)errorBlock{

    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                                     params:nil
                                                 httpMethod:kHTTPTRequstTypeDelete                                     
                                                        ssl:self.secure];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Success! curlString=%@", completedOperation.curlCommandLineString);
#endif
        completionBlock(completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
#if defined(SM_LOG_CURL_COMMANDS)
        NSLog(@"Error! curlString=%@", completedOperation.curlCommandLineString);
#endif
        errorBlock(error, completedOperation.responseJSON);
    }];
    
    [self enqueueOperation:operation];
    return operation;
    
}



#pragma mark Public custom methods



-(MKNetworkOperation*)getPublicInfoAboutUser:(NSString*)user
                             completionBlock:(VWWRedditAboutBlock)completionBlock
                                  errorBlock:(VWWErrorBlock)errorBlock{

    
    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@/about.json", self.config.userURI, user]
                  jsonDictionary:nil
                 completionBlock:^(id json){
                     VWWRedditAbout *about = nil;
                     [VWWRESTParser parseJSON:json about:&about];
                     completionBlock(about);
                 }
                      errorBlock:^(NSError *error, id responseJSON) {
                          errorBlock(error.localizedDescription);
                      }];
    
}

-(MKNetworkOperation*)loginWithForm:(VWWHTTPRedditForm*)form
                    completionBlock:(VWWRedditLoginBlock)completionBlock
                         errorBlock:(VWWErrorBlock)errorBlock{

    return [self httpPostEndpoint:[NSString stringWithFormat:@"%@", self.config.loginURI]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id json){
    
                     NSString *errorDescription;
                     if([VWWRESTParser parseJSON:json errorDescription:&errorDescription] == YES){
                         errorBlock(errorDescription);
                         return;
                     }
                     
                     VWWRedditLogin *login = nil;
                     [VWWRESTParser parseJSON:json data:&login];
                     if(login.errors.errors.count){
                         errorBlock(login.errors.errors.description);
                     }
                     else{
                         completionBlock(login);
                     }
                 }
                      errorBlock:^(NSError *error, id responseJSON) {
                          errorBlock(error.localizedDescription);
                      }];

}


-(MKNetworkOperation*)meWithForm:(VWWHTTPRedditForm*)form
                 completionBlock:(VWWStringBlock)completionBlock
                      errorBlock:(VWWErrorBlock)errorBlock{
    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@", self.config.meURI]
                   jsonDictionary:nil
                  completionBlock:^(id json){
                      
                      NSString *errorDescription;
                      if([VWWRESTParser parseJSON:json errorDescription:&errorDescription] == YES){
                          errorBlock(errorDescription);
                          return;
                      }

                      // TODO: parsing
                      completionBlock((NSString*)json);
                  }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error.localizedDescription);
                       }];
    
}

@end
