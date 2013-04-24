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

-(BOOL)isComplete{
    return !([self.user isEqualToString:@""] == YES ||
             [self.passwd isEqualToString:@""] == YES ||
             [self.modhash isEqualToString:@""] == YES ||
             [self.cookie isEqualToString:@""] == YES);
}
-(NSString*)description{
    return [NSString stringWithFormat:@"user=%@ passwd=%@ modhash=%@ cookie=%@", _user, _passwd, _modhash, _cookie];
}
@end
