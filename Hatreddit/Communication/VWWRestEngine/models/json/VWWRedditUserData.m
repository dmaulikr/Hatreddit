//
//  VWWRedditUserData.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWRedditUserData.h"




@implementation VWWRedditUserData

+(id)userWithDictionary:(NSDictionary *)dictionary{
    return [[VWWRedditUserData alloc]initWithDictionary:dictionary];
}


- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _commentKarma = [dictionary objectForKey:@"comment_karma"];
        _hasMail = [dictionary  valueForKey:@"has_mail"];
        if(_hasMail)
            _hasMail = @(1);
        else
            _hasMail = @(0);
        _linkKarma= [dictionary objectForKey:@"link_karma"];
        _name= [dictionary objectForKey:@"name"];
    }
    return self;
}


-(NSString*)description{
    return [NSString stringWithFormat:@"name:%@ has_verified_mail:%@ link_karma:%@ comment_karma:%@",
            _name, _hasMail, _linkKarma, _commentKarma];
}

@end
