//
//  BookmarkMasterViewController.m
//  Bookmark
//
//  Created by 玉城 辰朗 on 12/09/02.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "BookmarkMasterViewController.h"

#import "BookmarkDetailViewController.h"

@interface BookmarkMasterViewController () {
    NSMutableArray *_objects;
}
@end


@implementation BookmarkMasterViewController

@synthesize bookmarkDictionary;


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)dealloc
{
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //プロパティのパスを取得
    NSString *path = [[NSBundle mainBundle]pathForResource:@"bookmarks" ofType:@"plist"];
    
    //プロパティリストを辞書に読み込み
    bookmarkDictionary = [[NSDictionary alloc]initWithContentsOfFile:path];

    //タイトルの設定
    self.title = @"Bookmark";
  /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
*/
   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.bookmarkDictionary = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *bookmarks = [bookmarkDictionary objectForKey:@"bookmarks"];
    return [bookmarks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *bookmarks = [bookmarkDictionary objectForKey:@"bookmarks"];
    NSDictionary *bookmark = [bookmarks objectAtIndex:indexPath.row];
    cell.textLabel.text = [bookmark objectForKey:@"name"];
    
    return cell;
    
    
/*
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
*/
 }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
