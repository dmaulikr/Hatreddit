//
//  VWWRedditAbout.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWRedditUserData.h";


@interface VWWRedditAbout : NSObject
@property (nonatomic, strong) VWWRedditUserData *data;
@property (nonatomic, strong) NSString *kind;
@end
