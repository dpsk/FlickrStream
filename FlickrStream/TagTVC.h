//
//  TagTVC.h
//  FlickrStream
//
//  Created by dpsk on 21.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_NAME @"name"
#define TAG_COUNT @"count"
#define TAGS_TO_FILTER @[@"landscape", @"portrait", @"cs193pspot"]

@interface TagTVC : UITableViewController
@property (nonatomic, strong) NSArray *tags;
@end
