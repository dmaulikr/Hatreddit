//
//  VWWHTTPRedditForm.m
//  Smile
//
//  Created by Zakk Hoyt
//

#import "VWWHTTPRedditForm.h"


@implementation VWWHTTPRedditForm

- (NSDictionary *)httpParametersDictionary {
    NSAssert(NO, @"Subclasses must implement method");
    return nil;
}

- (NSString *)JSONString {
    return [[self httpParametersDictionary] jsonEncodedKeyValueString];
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
        dictionary[key] = [self stringFromDate:value usingFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss UTC"];
    }
    else {
        dictionary[key] = value;
    }
}


- (NSString *)stringFromDate:(NSDate *)date usingFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
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
