//
//  VWWRedditErrors.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWRedditErrors : NSObject
@property (nonatomic, strong) NSArray* errors;
+ (id)errorsWithArray:(NSArray*)dictionary;
-(NSString*)description;
@end
