//
//  VWWHTTPRedditForm.h
//  Smile
//
//  Created by Zakk Hoyt
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
