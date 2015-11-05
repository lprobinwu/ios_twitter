//
//  LoginViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token"
                                                       method:@"GET"
                                                  callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"]
                                                        scope:nil
                                                      success:^(BDBOAuth1Credential *requestToken) {
                                                          NSLog(@"got the request token");
                                                          
                                                          NSURL *authURL = [NSURL URLWithString:
                                                                            [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",
                                                                             requestToken.token]];
                                                          
                                                          [[UIApplication sharedApplication] openURL:authURL];
                                                          
                                                      } failure:^(NSError *error) {
                                                          NSLog(@"Failed to get the request token");
                                                      }];
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
