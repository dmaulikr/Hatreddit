//
//  VWWRedditUserData.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface VWWRedditUserData : NSObject@property (nonatomic, strong) NSString* count;



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


@property (nonatomic, strong) NSString* commentKarma;
//@property (nonatomic, strong) NSString* created;
//@property (nonatomic, strong) NSString* createdUTC;
@property (nonatomic, strong) NSString* hasMail;
//@property (nonatomic, strong) NSString* hasModMail;
//@property (nonatomic, strong) NSString* hasVerifiedMail;
//@property (nonatomic, strong) NSString* identifier;
//@property (nonatomic, strong) NSString* isFriend;
//@property (nonatomic, strong) NSString* isGold;
//@property (nonatomic, strong) NSString* isMod;
@property (nonatomic, strong) NSString* linkKarma;
@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSString* overEighteen;

+ (id)userWithDictionary:(NSDictionary*)dictionary;
- (id)initWithDictionary:(NSDictionary*)dictionary;
-(NSString*)description;

@end
