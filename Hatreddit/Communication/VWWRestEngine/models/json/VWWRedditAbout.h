//
//  VWWRedditAbout.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWRedditUserData.h"
#import "VWWHTTPRedditLoginForm.h"


//data =     {
//    "comment_karma" = 2041;
//    created = 1255988260;
//    "created_utc" = 1255984660;
//    "has_mail" = "<null>";
//    "has_mod_mail" = "<null>";
//    "has_verified_email" = 1;
//    id = 3omda;
//    "is_friend" = 0;
//    "is_gold" = 0;
//    "is_mod" = 0;
//    "link_karma" = 3043;
//    name = sneeden;
//    "over_18" = 1;
//};
//kind = t2;

@interface VWWRedditAbout : NSObject
@property (nonatomic, strong) VWWRedditUserData *data;
@property (nonatomic, strong) NSString *kind;
@end
