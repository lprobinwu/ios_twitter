//
//  AppDelegate.m
//  Twitter
//
//  Created by Robin Wu on 11/5/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(useDidLogOut)
                                                 name:UserDidLogoutNotification
                                               object:nil];
    
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Welcome %@", user.name);
        
        HamburgerViewController *hamburgerVC = [[HamburgerViewController alloc] init];
        self.window.rootViewController = hamburgerVC;
        
        MenuViewController *menuVC = [[MenuViewController alloc] init];
        UINavigationController *menuNVC = [[UINavigationController alloc]initWithRootViewController:menuVC];
        
        [menuVC setHamburgerViewController:hamburgerVC];
        [hamburgerVC setMenuViewController:menuNVC];
        
    } else {
        NSLog(@"Not Logged In");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) useDidLogOut {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    [[TwitterClient sharedInstance] openURL:url];
    
    return YES;
}

@end
