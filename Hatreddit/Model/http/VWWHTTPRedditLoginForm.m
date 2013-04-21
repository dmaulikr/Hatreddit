//
//  VWWHTTPRedditLoginForm.m
//  Smile
//
//  Created by Aleksandar Tosovic on 5/28/12.
//  Copyright (c) 2012 DFANY. All rights reserved.
//

#import "VWWHTTPRedditLoginForm.h"

@implementation VWWHTTPRedditLoginForm


- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

//    dictionary[@"email"] = self.email;
    dictionary[@"user"] = self.user;
    dictionary[@"passwd"] = self.passwd;
    dictionary[@"api_type"] = @"json";
//    dictionary[@"username"] = self.username;
//    dictionary[@"password"] = self.password;

    return dictionary;
}

@end
