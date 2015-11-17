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
#import "HeaderProfileCell.h"
#import "User.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addCustomButtonOnNavBar];
    
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderProfileCell" bundle:nil] forCellReuseIdentifier:@"HeaderProfileCell"];
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
    
    self.viewControllers = [NSArray arrayWithObjects:profileNVC, tweetsNVC, profileNVC, mentionsNVC, nil];
    
    self.hamburgerViewController.contentViewController = tweetsNVC;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < 4) {
        [self.hamburgerViewController setContentViewController:self.viewControllers[indexPath.row]];
    } else {
        [self.hamburgerViewController setContentViewController:nil];
    }
}

- (void)addCustomButtonOnNavBar {
    UIBarButtonItem *item1= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Home"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *item2= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Message"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *item3= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Find"] style:UIBarButtonItemStylePlain target:self action:nil];
    NSArray * buttonArray =[NSArray arrayWithObjects:item1, item2, item3,nil];
    
    self.navigationItem.leftBarButtonItems =buttonArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HeaderProfileCell *headerProfileCell = [self.tableView dequeueReusableCellWithIdentifier:@"HeaderProfileCell"];
        [headerProfileCell setUser:[User currentUser]];
        [headerProfileCell setTwitterStyle];
        return headerProfileCell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text = @"Home Timeline";
            cell.imageView.image = [UIImage imageNamed:@"Home"];
            break;
        case 2:
            cell.textLabel.text = @"User Profile";
            cell.imageView.image = [UIImage imageNamed:@"User"];
            break;
        case 3:
            cell.textLabel.text = @"Mentions";
            cell.imageView.image = [UIImage imageNamed:@"Mention"];
            break;
        case 4:
            cell.textLabel.text = @"Notifications";
            cell.imageView.image = [UIImage imageNamed:@"Notification"];
            break;
        case 5:
            cell.textLabel.text = @"Messages";
            cell.imageView.image = [UIImage imageNamed:@"Message"];
            break;
        case 6:
            cell.textLabel.text = @"My Likes";
            cell.imageView.image = [UIImage imageNamed:@"Like"];
            break;
        case 7:
            cell.textLabel.text = @"Find People";
            cell.imageView.image = [UIImage imageNamed:@"Find"];
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
