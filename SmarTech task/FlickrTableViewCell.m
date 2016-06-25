//
//  FlickrTableViewCell.m
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "FlickrTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation FlickrTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCellWithFlickr:(FlickrImg *)flickr {
    
    self.flickr = flickr;
    
    self.lblTitle.text = flickr.title;
    NSString *imgURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_m.jpg", flickr.farm, flickr.server, flickr.imgID, flickr.secret];
    [self.imgViewMain setImageWithURL:[NSURL URLWithString:imgURL]
                     placeholderImage:nil];
}

@end
