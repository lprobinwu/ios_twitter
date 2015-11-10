//
//  TwitterClient.h
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion: (void (^)(User *user, NSError *error)) completion;

- (void) openURL: (NSURL *) url;

- (void) homeTimelineWithParams: (NSDictionary *)params completion: (void (^)(NSArray *tweets, NSError *error)) completion;

- (void) statusUpdateWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion;

- (void) statusRetweetWithStatusId:(NSString *)statusId completion:(void (^)(NSString *idString, NSError *error))completion;

- (void) statusGetRetweetIdWithStatusId:(NSString *)statusId completion:(void (^)(NSString *reTweetIdString, NSError *error))completion;

- (void) statusDestroyWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion;

- (void) addFavoritesWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion;

- (void) deleteFavoritesWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion;

@end
