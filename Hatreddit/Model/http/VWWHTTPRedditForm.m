//
//  VWWHTTPRedditForm.m
//  Smile
//
//  Created by Aleksandar Tosovic on 5/21/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import "VWWHTTPRedditForm.h"


@implementation VWWHTTPRedditForm

- (NSDictionary *)httpParametersDictionary {
    NSAssert(NO, @"Subclasses must implement method");
    return nil;
}

- (NSString *)JSONString {
    NSString *json;
    @autoreleasepool {
        json = [[self httpParametersDictionary] jsonEncodedKeyValueString];
    }
    return json;
}

- (void)setObject:(id)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    if (!value) return;

    if ([value isKindOfClass:[NSURL class]]) {
        dictionary[key] = [value absoluteString];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        dictionary[key] = [NSString stringWithFormat:@"%d", [value intValue]];
    }
    else if ([value isKindOfClass:[NSDate class]]) {
//        dictionary[key] = [[SMUtility sharedUtility] stringFromDate:value
//                                                            usingFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss UTC"];

    }
    else {
        dictionary[key] = value;
    }
}

- (void)setBool:(BOOL)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    dictionary[key] = value ? @"true" : @"false";
}



- (NSString *)descriptionForKeys:(NSString *)first, ... {
    NSMutableString *desc = [NSMutableString stringWithFormat:@"<%@:%p %@:%@",
                             NSStringFromClass([self class]), self,
                             first, [self valueForKey:first]];
    
    va_list args;
    va_start(args, first);
    for (NSString *key = nil; (key = va_arg(args, NSString *)); ) {
        [desc appendFormat:@" %@:%@", key, [self valueForKey:key]];
    }
    
    return [desc stringByAppendingString:@">"];
}

@end
