//
//  TweetCell.m
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end


@implementation TweetCell

- (void) setTweet: (Tweet *)tweet {
    _tweet = tweet;
//    self.timeLabel.text = [NSString stringWithFormat:@"%@", tweet.createdAt];
    self.timeLabel.text = @"some";
    self.tweetLabel.text = tweet.text;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", tweet.user.screenname];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    [self.tweetLabel sizeToFit];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
