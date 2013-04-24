//
//  VWWUserDefaults.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWUserDefaults : NSObject



+(NSString*)publicUsername;
+(void)setPublicUsername:(NSString*)username;

+(NSString*)username;
+(void)setUsername:(NSString*)username;

+(NSString*)password;
+(void)setPassword:(NSString*)password;

+(NSString*)modhash;
+(void)setModhash:(NSString*)modhash;

+(NSString*)cookie;
+(void)setCookie:(NSString*)cookie;


+(BOOL)showCommentKarmaInAppBadge;
+(void)setShowCommentKarmaInAppBadge:(BOOL)show;

+(BOOL)showLinkKarmaInAppBadge;
+(void)setShowLinkKarmaInAppBadge:(BOOL)show;

+(BOOL)showCommentKarmaInStatusBar;
+(void)setShowCommentKarmaInStatusBar:(BOOL)show;

+(BOOL)showLinkKarmaInStatusBar;
+(void)setShowLinkKarmaInStatusBar:(BOOL)show;

+(NSInteger)checkForNewKarmaTimer;
+(void)setCheckForNewKarmaTimer:(NSInteger)interval;


+(BOOL)appHasRunOnce;
+(void)setAppHasRunOnce:(BOOL)show;


@end
