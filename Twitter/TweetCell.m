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
        self.retweetImageView.tintColor = [Color twitterBlue];
    } else {
        self.retweetImageView.tintColor = [UIColor lightGrayColor];
    }

    self.likeImageView.image = [self.likeImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (tweet.favorited) {
        self.likeImageView.tintColor = [UIColor redColor];
    } else {
        self.likeImageView.tintColor = [UIColor lightGrayColor];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
