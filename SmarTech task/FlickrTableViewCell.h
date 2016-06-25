//
//  FlickrTableViewCell.h
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrTableViewCell : UITableViewCell

@property (nonatomic, strong) FlickrImg *flickr;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewMain;

-(void) setCellWithFlickr:(FlickrImg *)flickr;
@end
