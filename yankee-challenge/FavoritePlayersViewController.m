//
//  FavoritePlayersViewController.m
//  yankee-challenge
//
//  Created by Michael R Traverso on 6/7/15.
//  Copyright (c) 2015 hire mike traverso, inc. All rights reserved.
//

#import "FavoritePlayersViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PlayerTableViewCell.h"
#import "HttpClient.h"
#import "Player.h"
#import "PlayerDetailViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString *const PLAYER_TABLE_VIEW_CELL = @"PlayerTableViewCell";

@interface FavoritePlayersViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
    IBOutlet UITableView *_tblPlayers;
    NSMutableArray *_favoritePlayers;
}

@end

@implementation FavoritePlayersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Favorites";

    _tblPlayers.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSData *favoriteData = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlayers"];
    if (favoriteData != nil) {
        
        _favoritePlayers = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:favoriteData]];
    }
    else {
        
        _favoritePlayers = [NSMutableArray array];
    }
    
    [_tblPlayers setEditing:NO animated:NO];
    [_tblPlayers reloadData];
    
    if (_favoritePlayers.count > 0) {
        
        [self addEditNavigationBarButton];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    _tblPlayers.dataSource = nil;
    _tblPlayers.delegate = nil;
    _tblPlayers.emptyDataSetSource = nil;
    _tblPlayers.emptyDataSetDelegate = nil;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_favoritePlayers.count == 0) {
        
        self.navigationItem.rightBarButtonItem = 0;
    }
    
    return _favoritePlayers.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PLAYER_TABLE_VIEW_CELL];
    Player *player = [_favoritePlayers objectAtIndex:indexPath.row];
    [cell setupPlayerCell:player];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Player *player = (Player *) [_favoritePlayers objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:PlayerDetailViewControllerIdentifier sender:player];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Player *playerToMove = [_favoritePlayers objectAtIndex:sourceIndexPath.row];
    [_favoritePlayers removeObjectAtIndex:sourceIndexPath.row];
    [_favoritePlayers insertObject:playerToMove atIndex:destinationIndexPath.row];
    [_tblPlayers setEditing:NO animated:YES];
    [_tblPlayers reloadData];
    
    [self updateFavorites];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_favoritePlayers removeObjectAtIndex:indexPath.row];
        [_tblPlayers reloadData];
        [self updateFavorites];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:PlayerDetailViewControllerIdentifier]) {
        
        if ([sender isKindOfClass:[Player class]]) {
            
            PlayerDetailViewController *controller = segue.destinationViewController;
            [controller setPlayer:(Player*)sender];
        }
    }
}

#pragma mark - DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [UIImage imageNamed:@"star"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"Sorry, but you don't have any favorites.";
    
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0],
                                  NSForegroundColorAttributeName: [UIColor darkGrayColor] };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"Add your favorite players with the favorite button on the upper right side of the player's detail view.";
    
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

#pragma mark - Button handling

- (IBAction)editTablePressed {

    [_tblPlayers setEditing:!_tblPlayers.editing animated:YES];
}

- (void)updateFavorites {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_favoritePlayers];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"favoritePlayers"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addEditNavigationBarButton {
    
    UIBarButtonItem *editTableButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTablePressed)];
    self.navigationItem.rightBarButtonItem = editTableButtonItem;
}

@end
