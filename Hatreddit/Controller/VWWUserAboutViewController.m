//
//  VWWUserAboutViewController.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWUserAboutViewController.h"
#import "VWWRESTEngine.h"
#import "VWWRedditAbout.h"

@interface VWWUserAboutViewController ()
@property (strong) IBOutlet NSTextField *nameLabel;
@property (strong) IBOutlet NSTextField *commentKarmaLabel;
@property (strong) IBOutlet NSTextField *linkKarmaLabel;
@property (strong) IBOutlet NSTextField *hasMailLabel;
@end

@implementation VWWUserAboutViewController

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
    
    [[VWWRESTEngine sharedInstance] getAboutInfoUser:@"sneeden"
                                           completionBlock:^(VWWRedditAbout *about) {
                                               NSLog(@"Success: %@", about);
                                               self.nameLabel.stringValue = about.data.name;
                                               
                                               self.commentKarmaLabel.stringValue = about.data.commentKarma;
                                               NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
                                               NSString *dockTitle = [NSString stringWithFormat:@"%ld", about.data.commentKarma.integerValue];
                                               [tile setBadgeLabel:dockTitle];
                                               
                                               self.linkKarmaLabel.stringValue = about.data.linkKarma;
                                               
//                                               if(about.data.hasMail == (NSString*)[NSNull null]){
//                                                   self.hasMailLabel.stringValue = @"NO";
//                                               }
//                                               else{
//                                                   self.hasMailLabel.stringValue = @"YES";
//                                               }
//
//                                               if([about.data.hasMail isEqualToString:@"<null>"] == YES){
//                                                   self.hasMailLabel.stringValue = @"NO";
//                                               }
//                                               else{
//                                                   self.hasMailLabel.stringValue = @"YES";
//                                               }
//                                               
//                                               self.hasMailLabel.stringValue = @"asdfasd";
                                               
                                           } errorBlock:^(NSError *error, NSString *additionalInfo) {
                                               assert(NO);
                                           }];
}
@end
