//
//  FlickrImg+Json.h
//  SmarTech task
//
//  Created by islam metwally on 3/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "FlickrImg.h"

@interface FlickrImg (Json)

-(id) initWithDict:(NSDictionary *) dict;

+(void) getImagesWithSearchString:(NSString *)query andPage:(NSInteger)page WithSuccess:(void (^)(NSArray *results))successBlock andFailure:(void (^)(NSString *error))failureBlock;

+(void) getImagesForUserID:(NSString *)userID andPage:(NSInteger)page WithSuccess:(void (^)(NSArray *results))successBlock andFailure:(void (^)(NSString *error))failureBlock;

@end
