//
//  LatestFlickrPhotosTVC.m
//  FlickrStream
//
//  Created by dpsk on 19.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import "LatestFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface LatestFlickrPhotosTVC ()

@end

@implementation LatestFlickrPhotosTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [FlickrFetcher latestGeoreferencedPhotos];
}

@end
