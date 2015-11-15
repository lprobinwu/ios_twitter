//
//  ProfileCell.m
//  Twitter
//
//  Created by Robin Wu on 11/14/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;

@end

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(User *)user {
    // rounded corners and border for profile images
    CALayer *layer = [self.profileImageView layer];
    [layer setCornerRadius:6.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [layer setBorderWidth:3.0];
    [layer setMasksToBounds:YES];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    
    self.userNameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenname];
    self.locationLabel.text = user.location;
    
    // use friendly numbers like twitter
    self.tweetCountLabel.text = [self getFriendlyCount:user.tweetCount];
    self.followingCountLabel.text = [self getFriendlyCount:user.friendCount];
    self.followerCountLabel.text = [self getFriendlyCount:user.followerCount];
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

}

@end
