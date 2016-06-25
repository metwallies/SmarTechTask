//
//  FlickrImg.h
//  SmarTech task
//
//  Created by islam metwally on 3/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrImg : NSObject

@property (nonatomic, strong) NSString *imgID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *farm;
@property (nonatomic, strong) NSString *server;

// response example
/*
 Printing description of responseObject:
 {
 photos =     {
 page = 1;
 pages = 31849;
 perpage = 10;
 photo =         (
 {
 farm = 2;
 id = 26140382145;
 isfamily = 0;
 isfriend = 0;
 ispublic = 1;
 owner = "25578802@N04";
 secret = 9f018ebe7b;
 server = 1633;
 title = "FAILURE AT LIFTOFF";
 }
 );
 total = 318487;
 };
 stat = ok;
 }
 */

@end
