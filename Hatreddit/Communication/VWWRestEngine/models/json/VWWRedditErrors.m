//
//  VWWRedditErrors.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRedditErrors.h"

@implementation VWWRedditErrors

+ (id)errorsWithDictionary:(NSDictionary*)dictionary{
    return [[VWWRedditErrors alloc]initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
    }
    return self;
}

-(NSString*)description{
    return @"";
}

@end
