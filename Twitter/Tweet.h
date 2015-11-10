//
//  Tweet.h
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, strong) NSString *timeDifference;
@property(nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL retweeted;

@property(nonatomic, strong) User *user;

- (id) initWithDictionary: (NSDictionary *) dictionary;

+ (NSArray *) tweetsWithArray: (NSArray *)array;

@end
