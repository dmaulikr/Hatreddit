//
//  VWWRedditErrors.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRedditErrors.h"

@implementation VWWRedditErrors

+ (id)errorsWithArray:(NSArray*)array{
    return [[VWWRedditErrors alloc]initWithArray:array];
}

- (id)initWithArray:(NSArray*)array{
    self = [super init];
    if(self){
        _errors = [NSArray arrayWithArray:array];
    }
    return self;
}

-(NSString*)description{
    return self.errors.description;
}

@end
