//
//  VWWAppDelegate.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//
//  https://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLoginItems.html#//apple_ref/doc/uid/10000172i-SW5-BAJJBJEG

#import "VWWAppDelegate.h"
//#import "VWWUserAboutViewController.h"
#import "VWWConfigureViewController.h"
#import "VWWUserDefaults.h"


@interface VWWAppDelegate () <NSWindowDelegate, VWWConfigureViewControllerDelegate>
@property (strong) VWWConfigureViewController *configureViewController;
@property (assign) IBOutlet NSMenu *statusMenu;
@property (strong) NSStatusItem * statusItem;
@end

@implementation VWWAppDelegate


-(void)awakeFromNib{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    NSImage *statusBarImage = [NSImage imageNamed:@"icon"];
    [statusBarImage setSize:NSMakeSize(28, 28)];
    [self.statusItem setImage:statusBarImage];
    [self.statusItem setHighlightMode:YES];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    [self writeDefaults];

    self.configureViewController = [[VWWConfigureViewController alloc]initWithNibName:@"VWWConfigureViewController" bundle:nil];
    self.configureViewController.delegate = self;
    self.configureViewController.view.frame = NSMakeRect(0, 0, 600, 260);
    [self.window.contentView addSubview:self.configureViewController.view];
    
    self.window.delegate = self;
    [NSApp activateIgnoringOtherApps:YES];
    

//    id service;
//    [NSApp setServicesProvider:service];
//    [self openWebBrowserAtURL:[NSURL URLWithString:@"http://www.reddit.com/"]];
}


-(void)writeDefaults{
    if([VWWUserDefaults appHasRunOnce] == NO){
        [VWWUserDefaults setShowCommentKarmaInAppBadge:NO];
        [VWWUserDefaults setShowCommentKarmaInStatusBar:YES];
        [VWWUserDefaults setShowLinkKarmaInAppBadge:YES];
        [VWWUserDefaults setShowLinkKarmaInStatusBar:YES];
        [VWWUserDefaults setAppHasRunOnce:YES];
        [VWWUserDefaults setCheckForNewKarmaTimer:10];
    }
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



// Shells a terminal command
-(void)runSystemCommand:(NSString*)cmd{
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh"
                              arguments:[NSArray arrayWithObjects:@"-c", cmd, nil]]
     waitUntilExit];
}	

// Shells system browser
-(void)openWebBrowserAtURL:(NSURL*)url{
    [[NSWorkspace sharedWorkspace] openURL:url];
}


#pragma mark IBActions
- (IBAction)openInBrowserMenuButtonAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    NSString *publicUsername = [VWWUserDefaults publicUsername];
    if([publicUsername isEqualToString:@""] == YES){
        [self openWebBrowserAtURL:[NSURL URLWithString:@"http://www.reddit.com"]];
    }
    else{
        [self openWebBrowserAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.reddit.com/u/%@", publicUsername]]];
    }
}

- (IBAction)configureButtonAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [self.window orderFront:self];
}
- (IBAction)aboutButtonAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
//    NSArray *screenArray = [NSScreen screens];
//    NSScreen *screen = screenArray[0];
//    NSRect screenFrame = [screen visibleFrame];
//    NSSize heloWndowSize = NSMakeSize(510, 204);
//    
//    NSRect frame = NSMakeRect(screenFrame.size.width / 2.0 - heloWndowSize.width / 2.0,
//                              screenFrame.size.height / 2.0 - heloWndowSize.height / 2.0,
//                              heloWndowSize.width,
//                              heloWndowSize.height);
//    
//    
//    
//    self.helpWindowController = [[VWWHelpWindowController alloc] initWithWindowNibName:@"VWWHelpWindowController"];
//    [self.helpWindowController.window setFrame:frame display:YES animate:YES];
//    [self.helpWindowController showWindow:self];
}

- (IBAction)quitButtonAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    [NSApp terminate:self];
}


#pragma mark Impelments VWWUserAboutViewControllerDelegate
-(void)configureViewController:(VWWConfigureViewController*)sender commentKarma:(NSString*)commentKarma linkKarma:(NSString*)linkKarma{
    // Set status bar icon numbers
    if([VWWUserDefaults showCommentKarmaInStatusBar] == YES && [VWWUserDefaults showLinkKarmaInStatusBar] == YES){
        [self.statusItem setTitle:[NSString stringWithFormat:@"%@/%@", commentKarma, linkKarma]];
    }
    else if([VWWUserDefaults showCommentKarmaInStatusBar] == YES){
        [self.statusItem setTitle:[NSString stringWithFormat:@"%@", commentKarma]];
    }
    else if([VWWUserDefaults showLinkKarmaInStatusBar] == YES){
        [self.statusItem setTitle:[NSString stringWithFormat:@"%@", linkKarma]];
    }
    else{
        [self.statusItem setTitle:[NSString stringWithFormat:@""]];
    }
    
    // Set app badge numbers
    NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
    NSString *dockTitle;
    if([VWWUserDefaults showCommentKarmaInAppBadge] == YES && [VWWUserDefaults showLinkKarmaInAppBadge] == YES){
        dockTitle = [NSString stringWithFormat:@"%@/%@", commentKarma, linkKarma];
    }
    else if([VWWUserDefaults showCommentKarmaInAppBadge] == YES){
        dockTitle = [NSString stringWithFormat:@"%@", commentKarma];
    }
    else if([VWWUserDefaults showLinkKarmaInAppBadge] == YES){
        dockTitle = [NSString stringWithFormat:@"%@", linkKarma];
    }
    else{
        dockTitle = [NSString stringWithFormat:@""];
    }
    [tile setBadgeLabel:dockTitle];
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
    self.configureViewController.view.frame = [self entireWindow];
}

@end
