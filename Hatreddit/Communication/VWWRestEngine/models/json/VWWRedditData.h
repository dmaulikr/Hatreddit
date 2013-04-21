//
//  VWWRedditData.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWRedditData : NSObject
@property (nonatomic, strong) NSString *cookie;
@property (nonatomic, strong) NSString *modhash;

+ (id)dataWithDictionary:(NSDictionary*)dictionary;
//- (id)initWithDictionary:(NSDictionary*)dictionary;
-(NSString*)description;

@end
