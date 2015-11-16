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
#import "MentionsViewController.h"
#import "Color.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIViewController *tweetsViewController = [[TweetsViewController alloc]init];
    UINavigationController *tweetsNVC = [[UINavigationController alloc] initWithRootViewController:tweetsViewController];

    UIViewController *profileViewController = [[ProfileViewController alloc]init];
    UINavigationController *profileNVC = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    profileNVC.navigationBar.barTintColor = [Color twitterBlue];
    profileNVC.navigationBar.tintColor = [UIColor whiteColor];
    [profileNVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    profileNVC.navigationBar.translucent = NO;
    
    UIViewController *mentionsViewController = [[MentionsViewController alloc]init];
    UINavigationController *mentionsNVC = [[UINavigationController alloc] initWithRootViewController:mentionsViewController];
    
    self.viewControllers = [NSArray arrayWithObjects:tweetsNVC, profileNVC, mentionsNVC, nil];
    
    self.hamburgerViewController.contentViewController = tweetsNVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < 3) {
        [self.hamburgerViewController setContentViewController:self.viewControllers[indexPath.row]];
    } else {
        [self.hamburgerViewController setContentViewController:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
        case 2:
            cell.textLabel.text = @"Mentions";
            break;
        case 3:
            cell.textLabel.text = @"Notifications";
            break;
        case 4:
            cell.textLabel.text = @"Messages";
            break;
        case 5:
            cell.textLabel.text = @"My Likes";
            break;
        case 6:
            cell.textLabel.text = @"Find People";
            break;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:21];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [Color twitterBlue];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
