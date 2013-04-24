//
//  VWWRESTParser.h
//  Smile
//
//  Created by Zakk Hoyt on 2/12/13.
//
//

#import <Foundation/Foundation.h>
@class VWWRedditAbout;
@class VWWRedditLogin;


@interface VWWRESTParser : NSObject
+(BOOL)parseJSON:(id)json about:(VWWRedditAbout**)albums;
+(BOOL)parseJSON:(id)json data:(VWWRedditLogin**)login;
+(BOOL)parseJSON:(id)json errorDescription:(NSString**)errorDescription;
@end
