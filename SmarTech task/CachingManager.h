//
//  CachingManager.h
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CachingManager : NSObject

+(id) sharedInstance;

-(void) saveFlickrImg:(FlickrImg *)flickr withQuery:(NSString *)searchString;

-(NSArray *) fetchFlickrsWithQuery:(NSString *)searchString;

-(NSArray *) fetchFlickrsWithOwner:(NSString *)owner;

-(void) saveFlickrImg:(FlickrImg *)flickr withOwner:(NSString *)owner;

@end
