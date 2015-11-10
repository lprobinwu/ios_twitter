//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/8/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numOfLikesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTweetDetailView];
    [self customizeImageViewsTapBahavior];
    [self customizeRightNavBarButtons];
}

- (void) initTweetDetailView {
    self.title = @"Tweet";
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", self.tweet.user.name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
    [self.screenNameLabel sizeToFit];

    self.tweetTextView.text = self.tweet.text;
    [self.tweetTextView sizeToFit];
    
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

- (void) customizeImageViewsTapBahavior {
    UITapGestureRecognizer *replyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReplyTapped)];
    replyTap.numberOfTapsRequired = 1;
    [self.replyImageView setUserInteractionEnabled:YES];
    [self.replyImageView addGestureRecognizer:replyTap];

    UITapGestureRecognizer *retweetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRetweetTapped)];
    retweetTap.numberOfTapsRequired = 1;
    [self.retweetImageView setUserInteractionEnabled:YES];
    [self.retweetImageView addGestureRecognizer:retweetTap];
    
    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLikeTapped)];
    likeTap.numberOfTapsRequired = 1;
    [self.likeImageView setUserInteractionEnabled:YES];
    [self.likeImageView addGestureRecognizer:likeTap];
}

- (void)customizeRightNavBarButtons {
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Reply"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(onReply)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) onReply {
    NSLog(@"On Reply Clicked");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.tweetTextView.text;
    params[@"in_reply_to_status_id"] = self.tweet.idStr;
    
    [[TwitterClient sharedInstance] statusUpdateWihParams:params completion:^(NSError *error) {
        if (error == nil) {
            [self goToHomeTimeLine];
        } else {
            NSLog(@"Failed to reply to tweet: %@", error);
        }
    }];
}

- (void) onReplyTapped {
    NSLog(@"On Reply Tapped");
    self.tweetTextView.text = [NSString stringWithFormat:@"@%@ ", self.tweet.user.screenname];
    [self.tweetTextView becomeFirstResponder];
}

- (void) onRetweetTapped {
    NSLog(@"On Retweet Tapped");
    [[TwitterClient sharedInstance] statusRetweetWithStatusId:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", [self.numOfRetweetsLabel.text intValue] + 1];
            [self goToHomeTimeLine];
        } else {
            NSLog(@"Failed to retweet: %@", error);
        }
    }];
}

- (void) onLikeTapped {
    NSLog(@"On Like Tapped");
    [[TwitterClient sharedInstance] addFavoritesWithStatusId:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            self.numOfLikesLabel.text = [NSString stringWithFormat:@"%d", [self.numOfLikesLabel.text intValue] + 1];
        } else {
            NSLog(@"Failed to favorite tweet: %@", error);
        }
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
