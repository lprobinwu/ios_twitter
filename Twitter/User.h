//
//  User.h
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *screenname;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, strong) NSString *profileImageUrl;
@property(nonatomic, strong) NSString *tagline;
@property(nonatomic, strong) NSNumber *favouritesCount;
@property(nonatomic, strong) NSString *backgroundImageUrl;
@property(nonatomic, strong) NSString *bannerUrl;
@property(nonatomic) NSInteger tweetCount;
@property(nonatomic) NSInteger friendCount;
@property(nonatomic) NSInteger followerCount;

- (id) initWithDictionary: (NSDictionary *) dictionary;

+ (User *) currentUser;
+ (void) setCurrentUser: (User *)currentUser;
+ (void) logout;

@end
