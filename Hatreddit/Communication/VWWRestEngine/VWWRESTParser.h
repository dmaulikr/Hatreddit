//
//  VWWRESTParser.h
//  Smile
//
//  Created by Zakk Hoyt on 2/12/13.
//
//

#import <Foundation/Foundation.h>
@class VWWRedditAbout;

@interface VWWRESTParser : NSObject
+(BOOL)parseJSON:(id)json about:(VWWRedditAbout**)albums;
@end