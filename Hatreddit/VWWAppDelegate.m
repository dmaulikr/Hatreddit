//
//  VWWAppDelegate.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWAppDelegate.h"
#import "VWWUserAboutViewController.h"




@interface VWWAppDelegate () <NSWindowDelegate>
@property (strong) VWWUserAboutViewController *userAboutViewController;
@end

@implementation VWWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    


// Makes window be full screen
//    NSArray *screenArray = [NSScreen screens];
//    NSScreen *screen = screenArray[0];
//    NSRect screenFrame = [screen visibleFrame];
//    [self.window setFrame:screenFrame display:YES];
    

    self.userAboutViewController = [[VWWUserAboutViewController alloc]initWithNibName:@"VWWUserAboutViewController" bundle:nil];
//    self.userAboutViewController.delegate = self;
    self.userAboutViewController.view.frame = [self entireWindow];
    [self.window.contentView addSubview:self.userAboutViewController.view];
    
    self.window.delegate = self;
    [NSApp activateIgnoringOtherApps:YES];
    
    
}


-(NSRect)entireWindow{
     return ((NSView*)self.window.contentView).bounds;
}

-(void)setWindowTint{
    //    CALayer self.progressViewCALayer = [CALayer layer];
    //    [self.progressViewCALayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.5)];
    //    [self.window setWantsLayer:YES];
    //    [self.progressView setLayer:self.progressViewCALayer];
}

-(NSRect)leftHalf{
    NSRect bounds = ((NSView*)self.window.contentView).bounds;
    return NSMakeRect(0,
                      0,
                      bounds.size.width / 2.0,
                      bounds.size.height);
}

-(NSRect)rightHalf{
    NSRect bounds = ((NSView*)self.window.contentView).bounds;
    return NSMakeRect(bounds.size.width / 2.0,
                      0,
                      bounds.size.width / 2.0,
                      bounds.size.height);
    
}

-(NSRect)topRight{
    
    NSRect bounds = ((NSView*)self.window.contentView).bounds;
    return NSMakeRect(bounds.size.width / 2.0,
                      bounds.size.height / 2.0,
                      bounds.size.width / 2.0,
                      bounds.size.height / 2.0);
    
}


-(NSRect)bottomRight{
    
    NSRect bounds = ((NSView*)self.window.contentView).bounds;
    return NSMakeRect(bounds.size.width / 2.0,
                      0,
                      bounds.size.width / 2.0,
                      bounds.size.height / 2.0);
    
}




#pragma mark Impelments NSWindowDelegate
- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize{
    NSLog(@"%@", NSStringFromSize(frameSize) );
    
    const CGFloat kMinWidth = 200;
    const CGFloat kMinHeight = 200;
    
    if(frameSize.width < kMinWidth && frameSize.height >= kMinHeight){
        return NSMakeSize(kMinWidth, frameSize.height);
    }
    
    if(frameSize.width >= kMinWidth && frameSize.height < kMinHeight){
        return NSMakeSize(frameSize.width, kMinHeight);
    }
    
    if(frameSize.width < kMinWidth && frameSize.height < kMinHeight){
        return NSMakeSize(kMinWidth, kMinHeight);
    }
    
    
    return frameSize;
}

- (void)windowDidResize:(NSNotification *)notification{
    self.userAboutViewController.view.frame = [self entireWindow];
}

@end
