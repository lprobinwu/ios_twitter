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
#import "Color.h"

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

@property (nonatomic, strong) NSString *retweetIdString;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTweetDetailView];
    [self customizeNavBarColorStyle];
    [self customizeImageViewsTapBahavior];
    [self customizeRightNavBarButtons];
}

- (void) initTweetDetailView {
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
    
    self.replyImageView.image = [self.replyImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.replyImageView.tintColor = [UIColor grayColor];
    
    self.retweetImageView.image = [self.retweetImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (self.tweet.retweeted) {
        self.retweetImageView.tintColor = [Color twitterBlue];
    } else {
        self.retweetImageView.tintColor = [UIColor lightGrayColor];
    }
    
    self.likeImageView.image = [self.likeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (self.tweet.favorited) {
        self.likeImageView.tintColor = [UIColor redColor];
    } else {
        self.likeImageView.tintColor = [UIColor lightGrayColor];
    }
}

- (void) customizeNavBarColorStyle {
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title = @"Tweet";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
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
    
    [[TwitterClient sharedInstance] statusUpdateWithParams:params completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Reply Tweet Done");
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
    if (self.tweet.retweeted) {
        [self deleteRetweet];
    } else {
        [self addRetweet];
    }
}

- (void) addRetweet {
    [[TwitterClient sharedInstance] statusRetweetWithStatusId:self.tweet.idStr completion:^(NSString *idString, NSError *error) {
        if (error == nil) {
            NSLog(@"Add Retweet Done");
            self.retweetIdString = idString;
            self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", [self.numOfRetweetsLabel.text intValue] + 1];
            self.retweetImageView.tintColor = [Color twitterBlue];
            self.tweet.retweeted = YES;
//            [self goToHomeTimeLine];
        } else {
            NSLog(@"Failed to add retweet: %@", error);
        }
    }];
}

- (void) deleteRetweet {
    if (self.retweetIdString == nil) {
        NSLog(@"Not Implemented yet, Need to get retweet id on initializing this page");
    }
    
    [[TwitterClient sharedInstance] statusDestroyWithStatusId:self.retweetIdString completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Delete Retweet Done");
            self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", [self.numOfRetweetsLabel.text intValue] - 1];
            self.retweetImageView.tintColor = [UIColor grayColor];
            self.tweet.retweeted = NO;
            self.retweetIdString = nil;
//            [self goToHomeTimeLine];
        } else {
            NSLog(@"Failed to delete retweet: %@", error);
        }
    }];
}

- (void) onLikeTapped {
    NSLog(@"On Like Tapped");
    if (self.tweet.favorited) {
        [self removeFavorites];
    } else {
        [self addFavorites];
    }
}

- (void) addFavorites {
    [[TwitterClient sharedInstance] addFavoritesWithStatusId:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Add Favorite Done");
            self.numOfLikesLabel.text = [NSString stringWithFormat:@"%d", [self.numOfLikesLabel.text intValue] + 1];
            self.likeImageView.tintColor = [UIColor redColor];
            self.tweet.favorited = YES;
        } else {
            NSLog(@"Failed to add favorite: %@", error);
        }
    }];
}

- (void) removeFavorites {
    [[TwitterClient sharedInstance] deleteFavoritesWithStatusId:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Delete Favorite Done");
            self.numOfLikesLabel.text = [NSString stringWithFormat:@"%d", [self.numOfLikesLabel.text intValue] - 1];
            self.likeImageView.tintColor = [UIColor grayColor];
            self.tweet.favorited = NO;
        } else {
            NSLog(@"Failed to delete favorite: %@", error);
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


@end
