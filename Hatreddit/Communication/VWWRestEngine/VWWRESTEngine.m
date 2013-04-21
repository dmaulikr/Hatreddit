//
//  SmileEngine.m
//  JSON
//
//  Created by Zakk Hoyt on 2/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRESTEngine.h"
#import "VWWRESTConfig.h"
#import "VWWRedditAbout.h"
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
@end

@implementation VWWRESTEngine

#pragma mark Overrides MKNetworkEngine

+(VWWRESTEngine*)sharedInstance{
    static VWWRESTEngine *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWRESTEngine alloc]init];
    });
    return instance;
}

-(id)init{
    if(self){

        //http://www.reddit.com/user/sneeden/about.json
        self.config = [VWWRESTConfig sharedInstance];
        self = [super initWithHostName:self.config.domain
                               apiPath:nil
                    customHeaderFields:nil];
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
                                                 httpMethod:kHTTPTRequstTypeGet];
    
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


-(MKNetworkOperation*) httpPostEndpoint:(NSString*)endpoint
                         jsonDictionary:(NSDictionary*)jsonDictionary
                         completionBlock:(PSESuccessBlock)completionBlock
                              errorBlock:(PSEErrorBlock)errorBlock{

    MKNetworkOperation* operation = [self operationWithPath:endpoint
                                              params:jsonDictionary
                                          httpMethod:kHTTPTRequstTypePost];
    
    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
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
                                          httpMethod:kHTTPTRequstTypePut];
    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
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
                                                 httpMethod:kHTTPTRequstTypeDelete];
    
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

-(MKNetworkOperation*)getAboutInfoUser:(NSString*)user
                             completionBlock:(VWWRedditAboutBlock)completionBlock
                                  errorBlock:(VWWErrorBlock)errorBlock{

    //http://www.reddit.com/user/sneeden/about.json
    
    return [self httpGetEndpoint:[NSString stringWithFormat:@"%@/%@/about.json", self.config.userURI, user]
                  jsonDictionary:nil
                 completionBlock:^(id json){
                     VWWRedditAbout *about = nil;
                     [VWWRESTParser parseJSON:json about:&about];
                     
                     completionBlock(about);
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];
    
}


@end
