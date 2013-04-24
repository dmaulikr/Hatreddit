//
//  VWWConfigureViewController.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWConfigureViewController.h"
#import "VWWRESTEngine.h"
#import "VWWRedditAbout.h"
#import "VWWRedditLogin.h"
#import "VWWUserDefaults.h"
#import "VWWNumberFormatter.h"

@interface VWWConfigureViewController ()
@property (strong) IBOutlet NSTextField *nameLabel;
@property (strong) IBOutlet NSTextField *commentKarmaLabel;
@property (strong) IBOutlet NSTextField *linkKarmaLabel;
@property (strong) IBOutlet NSTextField *hasMailLabel;
@property (strong) IBOutlet NSTextField *publicUsernameTextField;
@property (strong) IBOutlet NSTextField *usernameTextField;
@property (strong) IBOutlet NSSecureTextField *passwordTextField;
@property (strong) IBOutlet NSTextField *modhashLabel;
@property (strong) IBOutlet NSTextField *cookieLabel;
@property (strong) IBOutlet NSTabView *tabView;
@property (strong) IBOutlet NSButton *showLinkKarmaInStatusBarButton;
@property (strong) IBOutlet NSButton *showCommentKarmaInStatusBarButton;
@property (strong) IBOutlet NSButton *showLinkKarmaInAppBadgeButton;
@property (strong) IBOutlet NSButton *showCommentKarmaInAppBadgeButton;
@property (strong) NSString *commentKarma;
@property (strong) NSString *linkKarma;
@property (strong) IBOutlet NSTextField *timeIntervalTextField;
@property (strong) NSTimer *checkForNewKarmaTimer;

@end

@implementation VWWConfigureViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)loadView{
    [super loadView];
    
    VWWNumberFormatter *numberFormatter = [[VWWNumberFormatter alloc]init];
    self.timeIntervalTextField.formatter = numberFormatter;
    

    [self.tabView selectFirstTabViewItem:self];
    [self.showCommentKarmaInAppBadgeButton setState:[VWWUserDefaults showCommentKarmaInAppBadge]];
    [self.showCommentKarmaInStatusBarButton setState:[VWWUserDefaults showCommentKarmaInStatusBar]];
    [self.showLinkKarmaInAppBadgeButton setState:[VWWUserDefaults showLinkKarmaInAppBadge]];
    [self.showLinkKarmaInStatusBarButton setState:[VWWUserDefaults showLinkKarmaInStatusBar]];
    self.timeIntervalTextField.stringValue = [NSString stringWithFormat:@"%ld",[VWWUserDefaults checkForNewKarmaTimer]];
    [self bounceTimer:[VWWUserDefaults checkForNewKarmaTimer]];
    
    NSString* publicUsername = [VWWUserDefaults publicUsername];
    if([publicUsername isEqualToString:@""] == NO){
        [self getPublicInfoForUser:publicUsername];
    }
}

-(void)getPublicInfoForUser:(NSString*)user{
    
    VWWHTTPRedditLoginForm *form = [VWWHTTPRedditLoginForm new];
    form.user = user;
    
    // TODO: have this api take a form instead of a string
    [[VWWRESTEngine publicInstance] getPublicInfoAboutUser:form.user
                                           completionBlock:^(VWWRedditAbout *about) {
                                               NSLog(@"Success: %@", about);
                                               self.nameLabel.stringValue = about.data.name;
                                               self.commentKarmaLabel.stringValue = about.data.commentKarma;
                                               self.linkKarmaLabel.stringValue = about.data.linkKarma;
                                               self.publicUsernameTextField.stringValue = form.user;
                                               self.hasMailLabel.stringValue = [NSString stringWithFormat:@"%@", about.data.hasMail];
                                               [VWWUserDefaults setPublicUsername:form.user];
                                               self.commentKarma = about.data.commentKarma;
                                               self.linkKarma = about.data.linkKarma;
                                               [self.delegate configureViewController:self commentKarma:self.commentKarma  linkKarma:self.linkKarma];
                                               
                                           } errorBlock:^(NSString *errorDescription) {
                                               NSLog(@"ERROR! %@", errorDescription);
                                               assert(NO);
                                           }];
    
}





-(void)bounceTimer:(NSInteger)minutes{
    if(self.checkForNewKarmaTimer){
        [self.checkForNewKarmaTimer invalidate];
        self.checkForNewKarmaTimer = nil;
    }
    self.checkForNewKarmaTimer = [NSTimer scheduledTimerWithTimeInterval:(minutes/*( * 60*/)
                                                          target:self
                                                        selector:@selector(checkForNewKarmaTimerAction)
                                                        userInfo:nil
                                                         repeats:YES];
    
}

-(void)checkForNewKarmaTimerAction{
    NSLog(@"%s", __FUNCTION__);
    NSString *publicUsername = [VWWUserDefaults publicUsername];
    if([publicUsername isEqualToString:@""] == NO){
        [self getPublicInfoForUser:publicUsername];
    }
    else{
        NSLog(@"Invalid public user");
    }
}

#pragma mark IBActions

- (IBAction)newKarmaIntervalTextFieldAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    NSTextField *textField = (NSTextField*)sender;
    [VWWUserDefaults setCheckForNewKarmaTimer:textField.integerValue];
    [self bounceTimer:textField.integerValue];
}


- (IBAction)showLinkKarmaInStatusBarButtonAction:(id)sender {
    NSButton *button = (NSButton*)sender;
    [VWWUserDefaults setShowLinkKarmaInStatusBar:button.state];
    [self.delegate configureViewController:self commentKarma:self.commentKarma  linkKarma:self.linkKarma];
}

- (IBAction)showCommentKarmaInStatusBarButtonAction:(id)sender {
    NSButton *button = (NSButton*)sender;
    [VWWUserDefaults setShowCommentKarmaInStatusBar:button.state];
    [self.delegate configureViewController:self commentKarma:self.commentKarma  linkKarma:self.linkKarma];
}

- (IBAction)showLinkKarmaInAppBadgeButtonAction:(id)sender {
    NSButton *button = (NSButton*)sender;
    [VWWUserDefaults setShowLinkKarmaInAppBadge:button.state];
    [self.delegate configureViewController:self commentKarma:self.commentKarma  linkKarma:self.linkKarma];
}

- (IBAction)showCommetnKarmaInAppBadgeButtonAction:(id)sender {
    NSButton *button = (NSButton*)sender;
    [VWWUserDefaults setShowCommentKarmaInAppBadge:button.state];
    [self.delegate configureViewController:self commentKarma:self.commentKarma  linkKarma:self.linkKarma];
}

- (IBAction)setPublicUserButtonAction:(id)sender {
    [self getPublicInfoForUser:self.publicUsernameTextField.stringValue];
}

- (IBAction)loginButtonAction:(id)sender {
    VWWHTTPRedditLoginForm *form = [VWWHTTPRedditLoginForm new];
    form.user = self.usernameTextField.stringValue;
    form.passwd = self.passwordTextField.stringValue;
    
    [[VWWRESTEngine privateInstance] loginWithForm:form
                                   completionBlock:^(VWWRedditLogin *login) {
                                       NSLog(@"");
                                       self.modhashLabel.stringValue = login.data.modhash;
                                       self.cookieLabel.stringValue = login.data.cookie;
                                       
                                       // Write settings to non-volatile storage
                                       
                                       [VWWUserDefaults setUsername:form.user];
                                       [VWWUserDefaults setPassword:form.passwd];
                                       [VWWUserDefaults setCookie:login.data.cookie];
                                       [VWWUserDefaults setModhash:login.data.modhash];
                                   } errorBlock:^(NSString *errorDescription) {
                                       NSLog(@"ERROR(s)! %@", errorDescription);
                                   }];

}




@end
