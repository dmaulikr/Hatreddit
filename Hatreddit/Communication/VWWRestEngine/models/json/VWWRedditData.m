//
//  VWWRedditData.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRedditData.h"

@implementation VWWRedditData


+ (id)dataWithDictionary:(NSDictionary*)dictionary{
    return [[VWWRedditData alloc]initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
        _cookie = dictionary[@"cookie"];
        _modhash = dictionary[@"modhash"];
    }
    return self;
}

-(NSString*)description{
    return  [NSString stringWithFormat:@"cookie=%@ modhash=%@", self.cookie, self.modhash];
}



@end
