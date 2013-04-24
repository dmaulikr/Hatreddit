//
//  VWWRESTParser.m
//  Smile
//
//  Created by Zakk Hoyt on 2/12/13.
//
//

#import "VWWRESTParser.h"
#import "VWWRedditAbout.h"
#import "VWWRedditUserData.h"
#import "VWWRedditData.h"
#import "VWWRedditErrors.h"
#import "VWWRedditLogin.h"


@implementation VWWRESTParser

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
+(BOOL)parseJSON:(NSDictionary*)json about:(VWWRedditAbout**)about{
    if(json == nil){
        return NO;
    }

    *about = [[VWWRedditAbout alloc]init];
    NSDictionary *dataDictionary = json[@"data"];
    VWWRedditUserData *data = [VWWRedditUserData userWithDictionary:dataDictionary];
    NSString *kind = json[@"kind"];
    
    (*about).data = data;
    (*about).kind = kind;
    
    return YES;
}


//{
//    json =     {
//        data =         {
//            cookie = "12394811,2013-04-20T22:42:57,308080f8dcea3b13ae6e3db21e487e4ce8d9a23b";
//            modhash = wl5ch9axap008f603fb3d014324c87422e178156207069c7c5;
//        };
//        errors =         (
//        );
//    };
//}
+(BOOL)parseJSON:(id)json data:(VWWRedditLogin**)login{
    
    NSDictionary *jsonDictionary = json[@"json"];
    NSDictionary *dataDictionary = jsonDictionary[@"data"];
    *login = [[VWWRedditLogin alloc]init];
    (*login).data = [VWWRedditData dataWithDictionary:dataDictionary];
    return YES;
}


//{
//    json =     {
//        errors =         (
//                          (
//                           "WRONG_PASSWORD",
//                           "invalid password",
//                           passwd
//                           )
//                          );
//    };
//}
+(BOOL)parseJSON:(id)json errorDescription:(NSString**)errorDescription{
    NSDictionary *jsonDictionary = json[@"json"];
    NSArray *errorsArray = jsonDictionary[@"errors"];
    if(errorsArray == nil || errorsArray.count == 0) return NO;
    
    // Do all errors return an array of size 3? Seems like element 1 is the most user friendly to read, so return that if possible.
    if(errorsArray.count >= 2) (*errorDescription) = [NSString stringWithFormat:@"%@", errorsArray[1]];
    else if(errorsArray.count >= 1) (*errorDescription) = [NSString stringWithFormat:@"%@", errorsArray[0]];

    return YES;
}



@end
