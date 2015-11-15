//
//  TweetsViewController.h
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController

- (id)initWithTagName:(NSString *)tagName;
@property(nonatomic, strong) NSString *tagName;

@end
