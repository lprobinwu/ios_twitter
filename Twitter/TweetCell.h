//
//  TweetCell.h
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;

- (void) setTweet: (Tweet *)tweet;

@end
