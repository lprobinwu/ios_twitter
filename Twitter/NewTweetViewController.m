//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/8/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "NewTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "Color.h"

@interface NewTweetViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self loadUserInfo];
    [self customizeNavBarColorStyle];
    [self customizeRightNavBarButtons];
}

- (void) loadUserInfo {
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", [User currentUser].name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", [User currentUser].screenname];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:[User currentUser].profileImageUrl]];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 5;
    
    [self.tweetTextView becomeFirstResponder];
}

- (void) customizeNavBarColorStyle {
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)customizeRightNavBarButtons {
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Tweet"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(onNewTweet)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) onNewTweet {
    NSLog(@"on creating new tweet");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.tweetTextView.text;
    [[TwitterClient sharedInstance] statusUpdateWithParams:params completion:^(NSError *error) {
        if (error == nil) {
            [self goToHomeTimeLine];
        } else {
            NSLog(@"Failed to post status: %@", error);
        }
    }];
    [self goToHomeTimeLine];
}

- (void) goToHomeTimeLine {
    UIViewController *tweetsViewController = [[TweetsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
