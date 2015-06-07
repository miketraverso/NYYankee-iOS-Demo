//
//  PlayerViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/5/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "PlayerViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PlayerTableViewCell.h"
#import "HttpClient.h"
#import "Player.h"

static NSString *const PLAYER_TABLE_VIEW_CELL = @"PlayerTableViewCell";

@interface PlayerViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UISearchBarDelegate> {
    
    IBOutlet UITableView *tblPlayers;
    IBOutlet UISearchBar *searchBarPlayer;
    NSArray *searchResults;
}

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    tblPlayers.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    tblPlayers.dataSource = nil;
    tblPlayers.delegate = nil;
    tblPlayers.emptyDataSetSource = nil;
    tblPlayers.emptyDataSetDelegate = nil;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return searchResults.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PLAYER_TABLE_VIEW_CELL];
    
    if (cell == nil) {
        
    }
    
    Player *player = [searchResults objectAtIndex:indexPath.row];
    [cell setupPlayerCell:player];
    return cell;
}

#pragma mark - UISearchBarDelegate 

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    if (searchBar == searchBarPlayer) {
        
        [searchBar setShowsCancelButton:YES];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    if (searchBar == searchBarPlayer) {
        
        [searchBar setShowsCancelButton:NO];
    }

    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    [HUD showInView:self.view];
    __weak JGProgressHUD *weakHud = HUD;

    NSString *searchCriteria = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    if (searchCriteria && ![searchCriteria isEqualToString:@""]) {
    
        [[HttpClient sharedClient] searchPlayers:searchCriteria completion:^(NSInteger statusCode, NSMutableArray *results, NSError *error) {
        
            searchResults = results;
            [weakHud dismissAnimated:YES];
            [tblPlayers reloadData];
        }];
    }
    else {
        
        // Invalid input
    }
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    if (searchBar == searchBarPlayer) {

        [searchBar setText:@""];
        [searchBar setShowsCancelButton:NO];
    }

    [searchBar resignFirstResponder];
}

#pragma mark - DZNEmptyDataSetDelegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"Please use the search box above.";
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0],
                                  NSForegroundColorAttributeName: [UIColor darkGrayColor] };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"You can search for players using their first name, last name, first name and last name or first name initial and last name.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:16.0],
                                  NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                  NSParagraphStyleAttributeName: paragraph };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIColor whiteColor];
}

@end
