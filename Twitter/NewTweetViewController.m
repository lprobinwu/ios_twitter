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

@interface NewTweetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tweetTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadUserInfo];
    [self customizeRightNavBarButtons];
}

- (void) loadUserInfo {
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", [User currentUser].name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", [User currentUser].screenname];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:[User currentUser].profileImageUrl]];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 5;

}

- (void)customizeRightNavBarButtons {
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Tweet"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(createNewTweet)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) createNewTweet {
    NSLog(@"Creating new tweet");
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
