//
//  TweetsViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/7/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TweetsViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "TweetDetailsViewController.h"
#import "NewTweetViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tweets;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";
        [self customizeLeftNavBarButtons];
        [self customizeRightNavBarButtons];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpTableView];
    
    [self refreshTweetsWithCompletion:nil];
}

- (void)refreshTweetsWithCompletion:(void (^)())completion {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (tweets != nil) {
            self.tweets = tweets;
            [self.tableView reloadData];
            
            if (completion != nil) {
                completion();
            }
        }
    }];
}


- (void)customizeLeftNavBarButtons {
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Log Out"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(logout)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)customizeRightNavBarButtons {
    UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"New"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(openNewTweetView)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    [self setUpRefreshControl];
}

- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)onRefresh {
    [self refreshTweetsWithCompletion:^{
        [self.refreshControl endRefreshing];
    }];
}


- (void) logout {
    [User logout];
    NSLog(@"User logged out");
}

- (void) openNewTweetView {
    NewTweetViewController *vc = [[NewTweetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:self.tweets[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
