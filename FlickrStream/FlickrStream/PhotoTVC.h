//
//  PhotoTVC.h
//  FlickrStream
//
//  Created by dpsk on 19.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//
// Will call setImageUrl as part of "Show Image" segue

#import <UIKit/UIKit.h>

@interface PhotoTVC : UITableViewController
@property(nonatomic, strong) NSArray *photos; //of NSDictionary
@end
