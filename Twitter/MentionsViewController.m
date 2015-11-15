//
//  MentionsViewController.m
//  Twitter
//
//  Created by Robin Wu on 11/14/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "MentionsViewController.h"
#import "TweetCell.h"
#import "TwitterClient.h"
#import "Color.h"

@interface MentionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customizeNavBarColorStyle];
    [self setUpTableView];
    [self refreshMentions];
}

- (void)refreshMentions {
    [[TwitterClient sharedInstance] mentionsTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (error) {
            //
        } else {
            self.tweets = tweets;
            [self.tableView reloadData];
        }
    }];
}

- (void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
}

- (void) customizeNavBarColorStyle {
    UIColor *bgColor = [Color twitterBlue];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.title = @"Mentions";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    tweetCell.tweet = self.tweets[indexPath.row];
    
    return tweetCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
