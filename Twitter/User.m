//
//  User.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
    }
    
    return self;
}

@end
