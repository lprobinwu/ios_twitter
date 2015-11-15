//
//  TweetCell.m
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "Color.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerRetweetView;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameTopContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *screenNameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTopConstraint;

@end


@implementation TweetCell

- (void) setTweet: (Tweet *)tweet {
    _tweet = tweet;

    self.timeLabel.text = tweet.timeDifference;
    self.tweetLabel.text = tweet.text;
    [self.tweetLabel sizeToFit];
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", tweet.user.name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 5;
    
    self.replyImageView.image = [self.replyImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.replyImageView.tintColor = [UIColor lightGrayColor];
    
    self.retweetImageView.image = [self.retweetImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (tweet.retweeted) {
        self.retweetImageView.tintColor = [Color limeGreen];
    } else {
        self.retweetImageView.tintColor = [UIColor lightGrayColor];
    }

    self.likeImageView.image = [self.likeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (tweet.favorited) {
        self.likeImageView.tintColor = [UIColor redColor];
    } else {
        self.likeImageView.tintColor = [UIColor lightGrayColor];
    }
    
    self.headerRetweetView.image = [self.headerRetweetView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.headerRetweetView.tintColor = [Color twitterBlue];
    
    if (tweet.retweeted) {
        self.retweetLabel.text = [NSString stringWithFormat:@"%@ retweeted", tweet.user.name];
        [self.headerRetweetView setHidden:NO];
        [self.retweetLabel setHidden:NO];
        // update constraints dynamically
        self.profileTopConstraint.constant = 32;
        self.userNameTopContraint.constant = 32;
        self.screenNameTopConstraint.constant = 32;
        self.timeTopConstraint.constant = 32;

    } else {
        [self.headerRetweetView setHidden:YES];
        [self.retweetLabel setHidden:YES];
        // update constraints dynamically
        self.profileTopConstraint.constant = 6;
        self.userNameTopContraint.constant = 6;
        self.screenNameTopConstraint.constant = 6;
        self.timeTopConstraint.constant = 6;
    }
}

- (IBAction)onProfileTapped {
    NSLog(@"Profile tapped");
    if (_tweet.retweeted) {
        [self.delegate onProfile:_tweet.retweetedTweet.user];
    } else {
        [self.delegate onProfile:_tweet.user];
    }
}


- (void)awakeFromNib {
    // Initialization code
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileTapped)];
    singleTap.numberOfTapsRequired = 1;
    [self.profileImageView setUserInteractionEnabled:YES];
    [self.profileImageView addGestureRecognizer:singleTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
