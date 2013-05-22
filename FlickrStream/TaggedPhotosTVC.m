//
//  TaggedPhotosTVC.m
//  FlickrStream
//
//  Created by dpsk on 22.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import "TaggedPhotosTVC.h"
#import "FlickrFetcher.h"
@interface TaggedPhotosTVC ()

@end

@implementation TaggedPhotosTVC


- (void) setTagName:(NSString *)tagName
{
    _tagName = tagName;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.tagName)
    {
        [self loadTaggedPhotos];
    }
}


- (void)loadTaggedPhotos
{
    NSMutableArray *photosForTag = [[NSMutableArray alloc] init];
    NSArray *stanfordPhotos = [FlickrFetcher stanfordPhotos];
    for (NSDictionary *photo in stanfordPhotos) {
        NSMutableArray *filteredTags = (NSMutableArray *)[photo[FLICKR_TAGS] componentsSeparatedByString:@" "];
        for (NSString *tag in filteredTags) {
            if ([tag isEqualToString:self.tagName])
                [photosForTag addObject:photo];
        }
        
    }
    self.photos = photosForTag;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Image"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                    NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}


- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [[self.photos[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description];
}



@end
