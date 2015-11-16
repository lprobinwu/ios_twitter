//
//  ProfileViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/14/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "ProfileViewController.h"
#import "TwitterClient.h"
#import "ProfileCell.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "Color.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    [self customizeNavBarColorStyle];
    
    User *user = self.user ? self.user : [User currentUser];
    
    NSString *bannerUrl = user.bannerUrl ? [NSString stringWithFormat:@"%@/mobile_retina", user.bannerUrl] : user.backgroundImageUrl;
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:bannerUrl]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 155;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self refreshProfile];
}

- (void) customizeNavBarColorStyle {
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title = @"Profile";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}


- (void)refreshProfile {
    [[TwitterClient sharedInstance] userTimelineWithParams:nil user:self.user completion:^(NSArray *tweets, NSError *error) {
        if (error) {
            //
        } else {
            self.tweets = tweets;
            [self.tableView reloadData];
        }
        
        [self.view layoutIfNeeded];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        ProfileCell *profileCell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
        User *user;
        
        if (self.user) {
            user = self.user;
        } else {
            user = [User currentUser];
        }
        
        [profileCell setUser:user];
        profileCell.clipsToBounds = NO;
        [profileCell layoutIfNeeded];
        
        return profileCell;
    } else {
        TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
        tweetCell.tweet = self.tweets[indexPath.row - 1];
        
        [tweetCell layoutIfNeeded];
        return tweetCell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
