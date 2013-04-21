//
//  VWWHTTPRedditForm.h
//  Smile
//
//  Created by Aleksandar Tosovic on 5/21/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import <Foundation/Foundation.h>




@protocol SMServiceFormProtocol <NSObject>
@optional
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;
@end


@interface VWWHTTPRedditForm : NSObject <SMServiceFormProtocol>
- (NSDictionary *)httpParametersDictionary;
- (NSString *)JSONString;
- (void)setObject:(id)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (void)setBool:(BOOL)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary;
- (NSString *)descriptionForKeys:(NSString *)first, ...;
@end
