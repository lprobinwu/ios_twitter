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
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end


@implementation TweetCell

- (void) setTweet: (Tweet *)tweet {
    _tweet = tweet;
    NSString *createAtString = [NSDateFormatter localizedStringFromDate:tweet.createdAt
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterNoStyle];
    self.timeLabel.text = createAtString;
    self.tweetLabel.text = tweet.text;
    [self.tweetLabel sizeToFit];
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@", tweet.user.name];
    [self.userNameLabel sizeToFit];
    
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 5;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
