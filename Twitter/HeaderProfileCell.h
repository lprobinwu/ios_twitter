//
//  HeaderProfileCell.h
//  Twitter
//
//  Created by Robin Wu on 11/16/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface HeaderProfileCell : UITableViewCell

@property (strong, nonatomic) User *user;

- (void) setTwitterStyle;

@end
