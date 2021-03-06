//
//  TwitterClient.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"kuiNEc3nKLzu84RADyCy29w24";
NSString * const kTwitterConsumerSecret = @"c4quseUInswTUTi9YebEfB1SMmorYaGklkarqTz2mXO6SIs5Yw";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property(nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

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

- (void) loginWithCompletion: (void (^)(User *user, NSError *error)) completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];

    [self fetchRequestTokenWithPath:@"oauth/request_token"
           method:@"GET"
      callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"]
            scope:nil
          success:^(BDBOAuth1Credential *requestToken) {
              NSLog(@"got the request token");

              NSURL *authURL = [NSURL URLWithString:
                                [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@",
                                 requestToken.token]];

              [[UIApplication sharedApplication] openURL:authURL];

          } failure:^(NSError *error) {
              NSLog(@"Failed to get the request token");
              self.loginCompletion(nil, error);
          }];
}

- (void) openURL: (NSURL *) url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got the access token");

        [self.requestSerializer saveAccessToken:accessToken];

        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

            User *user = [[User alloc] initWithDictionary:responseObject];

            NSLog(@"Current user: %@", user.name);
            [User setCurrentUser:user];

            self.loginCompletion(user, nil);

        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"Failed to get the current user");

            self.loginCompletion(nil, error);
        }];

    } failure:^(NSError *error) {
        NSLog(@"Failed to get the access token");
        self.loginCompletion(nil, error);
    }];
}

- (void) homeTimelineWithParams: (NSDictionary *)params completion: (void (^)(NSArray *tweets, NSError *error)) completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"Got tweets");

        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) userTimelineWithParams:(NSDictionary *)params user:(User *)user completion:(void (^)(NSArray *tweets, NSError *error))completion {
    User *forUser = user ? user : [User currentUser];
    NSString *getUrl = [NSString stringWithFormat:@"1.1/statuses/user_timeline.json?include_rts=1&count=20&include_my_retweet=1&screen_name=%@",
                        forUser.screenname];
    [self GET:getUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"user timeline: %@", responseObject);
        
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) mentionsTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/mentions_timeline.json?include_my_retweet=1" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"mentions timeline: %@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}


- (void) statusUpdateWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion {
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success in Tweet Status Update");
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
}

- (void) statusRetweetWithStatusId:(NSString *)statusId completion:(void (^)(NSString *idString, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", statusId];
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *idStr = responseObject[@"id_str"];
        completion(idStr, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void) statusGetRetweetIdWithStatusId:(NSString *)statusId completion:(void (^)(NSString *reTweetIdString, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/show/%@.json?include_my_retweet=1", statusId];
    [self GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *idStr = responseObject[@"current_user_retweet"][@"id_str"];
        completion(idStr, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}


- (void) statusDestroyWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/destroy/%@.json", statusId];
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
}

- (void) addFavoritesWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = statusId;
    [self POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
}

- (void) deleteFavoritesWithStatusId:(NSString *)statusId completion:(void (^)(NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = statusId;
    [self POST:@"1.1/favorites/destroy.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
}


@end
