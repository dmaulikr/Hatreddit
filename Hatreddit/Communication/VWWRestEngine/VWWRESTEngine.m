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
@property (nonatomic) BOOL secure;
@end

@implementation VWWRESTEngine

#pragma mark Overrides MKNetworkEngine

//+(VWWRESTEngine*)sharedInstance{
//    static VWWRESTEngine *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[VWWRESTEngine alloc]init];
//    });
//    return instance;
//}

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
        if(public){
            //http://www.reddit.com/user/sneeden/about.json
            self.secure = NO;
            self.config = [VWWRESTConfig sharedInstance];
            self = [super initWithHostName:self.config.publicDomain
                                   apiPath:nil
                        customHeaderFields:nil];
        }
        else{
            //https://ssl.reddit.com/api/login
            self.secure = YES;
            self.config = [VWWRESTConfig sharedInstance];
            self = [super initWithHostName:self.config.privateEndpoint
                                   apiPath:nil
                        customHeaderFields:nil];
            
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
                                                 httpMethod:kHTTPTRequstTypePost
                                                        ssl:self.secure];
    
//    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
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
//    [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    
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

-(MKNetworkOperation*)loginWithForm:(VWWHTTPRedditForm*)form
                    completionBlock:(VWWStringBlock)completionBlock
                         errorBlock:(VWWErrorBlock)errorBlock{
    
    return [self httpPostEndpoint:[NSString stringWithFormat:@"%@", self.config.loginURI]
                  jsonDictionary:[form httpParametersDictionary]
                 completionBlock:^(id json){
//                     VWWRedditLogin *login = nil;
//                     [VWWRESTParser parseJSON:json about:&login];
                     
                     NSLog(@"%@", json);
                     completionBlock(@"");
                 }
                      errorBlock:^(NSError *error, id responseJSON){
                          errorBlock(error, responseJSON[@"message"]);
                      }];

}

@end
