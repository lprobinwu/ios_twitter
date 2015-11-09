//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/8/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfLikesLabel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTweetDetailView];
}

- (void) initTweetDetailView {
    self.title = @"Tweet";
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", self.tweet.user.name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
    [self.screenNameLabel sizeToFit];

    self.tweetLabel.text = self.tweet.text;
    [self.tweetLabel sizeToFit];
    
    NSString *createAtString = [NSDateFormatter localizedStringFromDate:self.tweet.createdAt
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
    self.createdAtLabel.text = createAtString;
    
    // take care of 0 if NSNumber is null.
    self.numOfRetweetsLabel.text = [self.tweet.retweetCount stringValue];
    self.numOfLikesLabel.text = [self.tweet.user.favouritesCount stringValue];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 5;
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
