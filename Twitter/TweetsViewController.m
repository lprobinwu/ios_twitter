//
//  TweetsViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetsViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"

@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"tweet: %@, created: %@", tweet.text, tweet.createdAt);
        }
    }];
}

- (IBAction)onLogout:(id)sender {
    [User logout];
    NSLog(@"User logged out");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
