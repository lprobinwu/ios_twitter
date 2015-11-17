//
//  HeaderProfileCell.m
//  Twitter
//
//  Created by Robin Wu on 11/16/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "HeaderProfileCell.h"
#import "UIImageView+AFNetworking.h"
#import "Color.h"

@interface HeaderProfileCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *countFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation HeaderProfileCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(User *)user {
    // rounded corners and border for profile images
    CALayer *layer = [self.profileImageView layer];
    [layer setCornerRadius:6.0];
//    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
//    [layer setBorderWidth:3.0];
    [layer setMasksToBounds:YES];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    
    self.userNameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenname];
    self.locationLabel.text = user.location;
    
    // use friendly numbers like twitter
    self.countTweetsLabel.text = [self getFriendlyCount:user.tweetCount];
    self.countFollowingLabel.text = [self getFriendlyCount:user.friendCount];
    self.countFollowersLabel.text = [self getFriendlyCount:user.followerCount];
}

- (void) setTwitterStyle {
    self.backgroundColor = [Color twitterBlue];
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.locationLabel.textColor = [UIColor whiteColor];
    self.countTweetsLabel.textColor = [UIColor whiteColor];
    self.countFollowingLabel.textColor = [UIColor whiteColor];
    self.countFollowersLabel.textColor = [UIColor whiteColor];
    
    self.screenNameLabel.textColor = [Color lightWhite];
    self.tweetsLabel.textColor = [Color lightWhite];
    self.followingLabel.textColor = [Color lightWhite];
    self.followersLabel.textColor = [Color lightWhite];
    
}

- (NSString *) getFriendlyCount:(NSInteger)count {
    if (count >= 1000000) {
        return [NSString stringWithFormat:@"%.1fM", (double)count / 1000000];
    } else if (count >= 10000) {
        return [NSString stringWithFormat:@"%.1fK", (double)count / 1000];
    } else if (count >= 1000) {
        return [NSString stringWithFormat:@"%ld,%ld", (long)count / 1000, (long)count % 1000];
    } else {
        return [NSString stringWithFormat:@"%ld", (long)count];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
