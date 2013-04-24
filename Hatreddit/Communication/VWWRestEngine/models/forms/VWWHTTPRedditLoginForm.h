//
//  VWWHTTPRedditLoginForm.h
//  Smile
//
//  Created by Zakk Hoyt
//

#import "VWWHTTPRedditForm.h"

@interface VWWHTTPRedditLoginForm : VWWHTTPRedditForm
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *passwd;
@property (nonatomic, strong) NSString *apiType;
@property (nonatomic, strong) NSString *modhash;
@property (nonatomic, strong) NSString *cookie;
-(NSString*)description;
-(BOOL)isComplete;
@end
