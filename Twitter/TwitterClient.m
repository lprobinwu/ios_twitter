//
//  TwitterClient.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"kuiNEc3nKLzu84RADyCy29w24";
NSString * const kTwitterConsumerSecret = @"c4quseUInswTUTi9YebEfB1SMmorYaGklkarqTz2mXO6SIs5Yw";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]
                                                  consumerKey:kTwitterConsumerKey
                                               consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}

@end
