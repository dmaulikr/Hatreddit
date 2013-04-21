//
//  VWWHTTPRedditLoginForm.m
//  Smile
//
//  Created by Zakk Hoyt
//

#import "VWWHTTPRedditLoginForm.h"

@implementation VWWHTTPRedditLoginForm

- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [@{}mutableCopy];
    dictionary[@"user"] = self.user;
    dictionary[@"passwd"] = self.passwd;
    dictionary[@"api_type"] = @"json";
    return dictionary;
}

@end
