//
//  VWWUserDefaults.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWUserDefaults.h"

__attribute ((unused)) static NSString* kVWWPublicUsernameKey = @"public_username";
__attribute ((unused)) static NSString* kVWWUsernameKey = @"username";
__attribute ((unused)) static NSString* kVWWPasswordKey = @"password";
__attribute ((unused)) static NSString* kVWWModhashKey = @"modhash";
__attribute ((unused)) static NSString* kVWWCookieKey = @"cookie";
__attribute ((unused)) static NSString* kVWWShowCommentKarmaInAppBadgeKey = @"comment_karma_in_app_badge";
__attribute ((unused)) static NSString* kVWWShowLinkKarmaInAppBadgeKey = @"link_karma_in_app_badge";
__attribute ((unused)) static NSString* kVWWShowCommentKarmaInStatusBarKey = @"comments_in_status_bar";
__attribute ((unused)) static NSString* kVWWShowLinkKarmaInStatusBarKey = @"link_commants_in_status_bar";
__attribute ((unused)) static NSString* kVWWAppHasRunOnceKey = @"app_has_run_once";
__attribute ((unused)) static NSString* kVWWNewKarmaIntervalKey = @"new_karma_interval";
@implementation VWWUserDefaults


+(void)setUserDefault:(id)object forKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}
+(void)setBoolUserDefault:(BOOL)object forKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:object forKey:key];
    [defaults synchronize];
}
+(void)setIntegerUserDefault:(NSInteger)object forKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:object forKey:key];
    [defaults synchronize];
}


+(NSString*)publicUsername{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVWWPublicUsernameKey];
}
+(void)setPublicUsername:(NSString*)username{
    [VWWUserDefaults setUserDefault:username forKey:kVWWPublicUsernameKey];
}



+(NSString*)username{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVWWUsernameKey];
}
+(void)setUsername:(NSString*)username{
    [VWWUserDefaults setUserDefault:username forKey:kVWWUsernameKey];
}

+(NSString*)password{
    // TODO: decrypt
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVWWPasswordKey];
}
+(void)setPassword:(NSString*)password{
    // TODO: encrypt
    [VWWUserDefaults setUserDefault:password forKey:kVWWPasswordKey];
}

+(NSString*)modhash{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVWWModhashKey];
}
+(void)setModhash:(NSString*)modhash{
    [VWWUserDefaults setUserDefault:modhash forKey:kVWWModhashKey];
}

+(NSString*)cookie{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVWWCookieKey];
}
+(void)setCookie:(NSString*)cookie{
    [VWWUserDefaults setUserDefault:cookie forKey:kVWWCookieKey];
}

+(BOOL)showCommentKarmaInAppBadge{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWShowCommentKarmaInAppBadgeKey];
}
+(void)setShowCommentKarmaInAppBadge:(BOOL)show{
    [VWWUserDefaults setBoolUserDefault:show forKey:kVWWShowCommentKarmaInAppBadgeKey];
}

+(BOOL)showLinkKarmaInAppBadge{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWShowLinkKarmaInAppBadgeKey];
}
+(void)setShowLinkKarmaInAppBadge:(BOOL)show{
    [VWWUserDefaults setBoolUserDefault:show forKey:kVWWShowLinkKarmaInAppBadgeKey];
}

+(BOOL)showCommentKarmaInStatusBar{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWShowCommentKarmaInStatusBarKey];
}
+(void)setShowCommentKarmaInStatusBar:(BOOL)show{
    [VWWUserDefaults setBoolUserDefault:show forKey:kVWWShowCommentKarmaInStatusBarKey];
}

+(BOOL)showLinkKarmaInStatusBar{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWShowLinkKarmaInStatusBarKey];
}
+(void)setShowLinkKarmaInStatusBar:(BOOL)show{
    [VWWUserDefaults setBoolUserDefault:show forKey:kVWWShowLinkKarmaInStatusBarKey];
}

+(NSInteger)checkForNewKarmaTimer{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kVWWNewKarmaIntervalKey];
}
+(void)setCheckForNewKarmaTimer:(NSInteger)interval{
    [VWWUserDefaults setIntegerUserDefault:interval forKey:kVWWNewKarmaIntervalKey];
}


+(BOOL)appHasRunOnce{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVWWAppHasRunOnceKey];
}
+(void)setAppHasRunOnce:(BOOL)show{
    [VWWUserDefaults setBoolUserDefault:show forKey:kVWWAppHasRunOnceKey];
}


@end
