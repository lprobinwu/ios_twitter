//
//  Tweet.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        self.text = dictionary[@"text"];
        self.retweetCount = dictionary[@"retweet_count"];
        self.retweeted = [(NSNumber *) dictionary[@"retweeted"] boolValue];
        self.favorited = [(NSNumber *)dictionary[@"favorited"] boolValue];
        self.idStr = dictionary[@"id_str"];
        
        if (self.retweeted) {
            if (dictionary[@"retweeted_status"] == nil) {
                self.originalTweetId = self.idStr;
            } else {
                self.originalTweetId = dictionary[@"retweeted_status"][@"id_str"];
            }
        }
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString:createdAtString];
        self.timeDifference = [self timeDifferencefrom:[NSDate date] since:self.createdAt];
        
        if (dictionary[@"retweeted_status"]) {
            self.retweetedTweet = [[Tweet alloc] initWithDictionary:dictionary[@"retweeted_status"]];
        }
    }
    
    return self;
}

+ (NSArray *) tweetsWithArray: (NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

- (NSString *) timeDifferencefrom: (NSDate *) fromDate since: (NSDate *) sinceDate {
    NSTimeInterval secondsBetween = [fromDate timeIntervalSinceDate:sinceDate];
    if (secondsBetween < 60) {
        return [NSString stringWithFormat:@"%lds", (long)secondsBetween];
    } else if (secondsBetween < 60 * 60) {
        return [NSString stringWithFormat:@"%ldm", (long)secondsBetween / 60];
    } else if (secondsBetween < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%ldh", (long)secondsBetween / 60 / 60];
    } else {
        return [NSString stringWithFormat:@"%ldd", (long)secondsBetween / 60 / 60 / 24];
    }
}

@end
