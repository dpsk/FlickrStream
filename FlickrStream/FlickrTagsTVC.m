//
//  FlickrTagsTVC.m
//  FlickrStream
//
//  Created by dpsk on 21.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import "FlickrTagsTVC.h"
#import "FlickrFetcher.h"
@interface FlickrTagsTVC ()

@end

@implementation FlickrTagsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tags = [self tagsFrequency];
    
}

- (NSArray *)tagsFrequency
{
    NSMutableDictionary *tagsFrequency = [[NSMutableDictionary alloc] init];
    NSArray *stanfordPhotos = [FlickrFetcher stanfordPhotos];
    for (NSDictionary *photo in stanfordPhotos) {
        NSMutableArray *filteredTags = (NSMutableArray *)[photo[FLICKR_TAGS] componentsSeparatedByString:@" "];
        [filteredTags removeObjectsInArray: TAGS_TO_FILTER];
        for (NSString *tag in filteredTags) {
            if ([tagsFrequency objectForKey:tag]){
                [tagsFrequency setObject:
                 [NSNumber numberWithInt: [[tagsFrequency objectForKey:tag] intValue] + 1]
                                  forKey:tag];
            } else {
                [tagsFrequency setObject:@"1" forKey:tag];
            }
        }
        
    }
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:tagsFrequency.count];
    [tagsFrequency enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [tags addObject:[[NSDictionary alloc] initWithObjects:@[key, obj] forKeys:@[TAG_NAME, TAG_COUNT]]];
    }];
    NSSortDescriptor *tagName = [[NSSortDescriptor alloc] initWithKey:TAG_NAME ascending:YES];
    return [tags sortedArrayUsingDescriptors:@[tagName]];
}
@end
