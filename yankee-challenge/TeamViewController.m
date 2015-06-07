//
//  TeamViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/6/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "TeamViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "TeamTableViewCell.h"
#import "HttpClient.h"
#import "Team.h"

static NSString *const TEAM_TABLE_VIEW_CELL = @"TeamTableViewCell";

@interface TeamViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    IBOutlet UITableView *tblTeams;
//    IBOutlet UISearchBar *searchBarPlayer;
    NSArray *searchResults;
}

@end

@implementation TeamViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
    __weak JGProgressHUD *weakHud = HUD;
    
    [[HttpClient sharedClient] getTeamsWithCompletion:^(NSInteger statusCode, NSMutableArray *results, NSError *error) {
            
        searchResults = results;
        [weakHud dismissAnimated:YES];
        [tblTeams reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    tblTeams.dataSource = nil;
    tblTeams.delegate = nil;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return searchResults.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TEAM_TABLE_VIEW_CELL];
    
    Team *team = [searchResults objectAtIndex:indexPath.row];
    [cell setupTeamCell:team];
    return cell;
}

@end
