//
//  MenuViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/14/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "MenuViewController.h"
#import "ProfileViewController.h"
#import "TweetsViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIViewController *tweetsViewController = [[TweetsViewController alloc]init];
    UINavigationController *tweetsNVC = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];

    UIViewController *profileViewController = [[ProfileViewController alloc]init];
    UINavigationController *profileNVC = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    profileNVC.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    profileNVC.navigationBar.tintColor = [UIColor whiteColor];
    [profileNVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    profileNVC.navigationBar.translucent = NO;
    
    self.viewControllers = [NSArray arrayWithObjects:tweetsNVC, profileNVC, nil];
    
    self.hamburgerViewController.contentViewController = tweetsNVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Home Timeline";
            break;
        case 1:
            cell.textLabel.text = @"User Profile";
            break;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21];
    cell.textLabel.textColor = [UIColor whiteColor];
    // use twitter color https://about.twitter.com/press/brand-assets
    cell.backgroundColor = [UIColor colorWithRed:85/255.0f green:172/255.0f blue:238/255.0f alpha:1.0f];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
