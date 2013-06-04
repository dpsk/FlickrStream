//
//  PhotoViewController.m
//  FlickrStream
//
//  Created by dpsk on 20.05.13.
//  Copyright (c) 2013 dpsk. All rights reserved.
//

#import "PhotoViewController.h"
#import "AttributedStringViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleBarButtonItem;
@property (strong, nonatomic) UIPopoverController *urlPopover;
@end

@implementation PhotoViewController
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Show URL"]){
        return self.imageURL && !self.urlPopover.popoverVisible ? YES : NO;
    } else {
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show URL"]) {
        if ([segue.destinationViewController isKindOfClass:[AttributedStringViewController class]]) {
            AttributedStringViewController *asc = (AttributedStringViewController *)segue.destinationViewController;
            asc.text = [[NSAttributedString alloc] initWithString:[self.imageURL description]];
            if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
                self.urlPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
            }

        }
    }
}
- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

- (void)setTitle:(NSString *)title
{
    super.title = title;
    self.titleBarButtonItem.title = title;
}

- (void)resetImage
{
    if (self.scrollView){
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            self.scrollView.zoomScale = 1.0;
            self.scrollView.contentSize = image.size;
            [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
    self.titleBarButtonItem.title = self.title;
}

// When subviews are layed out we set the zoom to make the image fit the screen.
- (void)viewDidLayoutSubviews
{
    if ((self.imageView.bounds.size.width)&&(self.imageView.bounds.size.height)) {
        CGFloat widthRatio  = self.scrollView.bounds.size.width  / self.imageView.bounds.size.width;
        CGFloat heightRatio = self.scrollView.bounds.size.height / self.imageView.bounds.size.height;
        self.scrollView.zoomScale = (widthRatio > heightRatio) ? widthRatio : heightRatio;
    }
}

@end
