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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Tagged"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setTagName:)]) {
                    [segue.destinationViewController performSelector:@selector(setTagName:)
                                                          withObject: [self.tags[indexPath.row] objectForKey:TAG_NAME]];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
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
