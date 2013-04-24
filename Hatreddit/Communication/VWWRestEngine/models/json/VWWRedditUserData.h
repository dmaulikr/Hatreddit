//
//  VWWRedditUserData.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface VWWRedditUserData : NSObject@property (nonatomic, strong) NSString* count;






@property (nonatomic, strong) NSString* commentKarma;
//@property (nonatomic, strong) NSString* created;
//@property (nonatomic, strong) NSString* createdUTC;
@property (nonatomic, strong) NSNumber* hasMail;
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
