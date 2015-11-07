//
//  User.h
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *screenname;
@property(nonatomic, strong) NSString *profileImageUrl;
@property(nonatomic, strong) NSString *tagline;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
