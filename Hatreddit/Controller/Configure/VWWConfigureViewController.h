//
//  VWWConfigureViewController.h
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VWWConfigureViewController;

@protocol VWWConfigureViewControllerDelegate <NSObject>
-(void)configureViewController:(VWWConfigureViewController*)sender commentKarma:(NSString*)commentKarma linkKarma:(NSString*)linkKarma;
@end

@interface VWWConfigureViewController : NSViewController
@property (weak) id <VWWConfigureViewControllerDelegate> delegate;
@end
