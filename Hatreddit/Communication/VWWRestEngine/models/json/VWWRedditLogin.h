//
//  VWWRedditLogin.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "VWWRedditData.h"
#import "VWWRedditErrors.h"

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

@interface VWWRedditLogin : NSObject
@property (nonatomic, strong) VWWRedditData *data;
@property (nonatomic, strong) VWWRedditErrors *errors;
@end
