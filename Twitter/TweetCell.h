//
//  TweetCell.h
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

- (void)onProfile:(User *)user;

@end


@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;

- (void) setTweet: (Tweet *)tweet;

@property (nonatomic, weak) id <TweetCellDelegate> delegate;

@end
