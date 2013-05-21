//
//  TagTVC.m
//  FlickrStream
//
//  Created by dpsk on 21.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import "TagTVC.h"

@interface TagTVC ()

@end

@implementation TagTVC

- (void)setTags:(NSArray *)tags
{
    _tags = tags;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Spot Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];

    return cell;
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [[self.tags[row] objectForKey:TAG_NAME] capitalizedString];
}

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [NSString stringWithFormat:@"%@ photos", [self.tags[row] objectForKey:TAG_COUNT]];
                                                     
}


@end
