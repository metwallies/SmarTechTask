//
//  FlickrImg+Json.m
//  SmarTech task
//
//  Created by islam metwally on 3/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "FlickrImg+Json.h"
#import <AFNetworking.h>

@implementation FlickrImg (Json)

-(id) initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    self.imgID  = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    self.title  = [NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    self.owner  = [NSString stringWithFormat:@"%@",[dict objectForKey:@"owner"]];
    self.secret = [NSString stringWithFormat:@"%@",[dict objectForKey:@"secret"]];
    self.farm   = [NSString stringWithFormat:@"%@",[dict objectForKey:@"farm"]];
    self.server = [NSString stringWithFormat:@"%@",[dict objectForKey:@"server"]];
    
    return self;
}

+(void)getImagesWithSearchString:(NSString *)query andPage:(NSInteger)page WithSuccess:(void (^)(NSArray *))successBlock andFailure:(void (^)(NSString *))failureBlock {
   
    if ([[CachingManager sharedInstance] fetchFlickrsWithQuery:query] && page == 1) {
        
        successBlock([[CachingManager sharedInstance] fetchFlickrsWithQuery:query]);
    } else {
    
        NSString *stringURL = [NSString stringWithFormat:@"%@&api_key=%@&tags=%@&page=%ld",BASE_URL,API_KEY,query,(long)page];
        NSURL *url = [NSURL URLWithString:stringURL];

        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [manager GET:stringURL
          parameters:nil
             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             if (responseObject) {
                 
                 NSMutableArray *result = [NSMutableArray new];
                 
                 NSDictionary *dict = [responseObject objectForKey:@"photos"];
                 NSArray *photo = [dict objectForKey:@"photo"];
                 
                 for (NSDictionary *photoDict in photo) {
                     
                     FlickrImg *img = [[FlickrImg alloc] initWithDict:photoDict];
                     [[CachingManager sharedInstance] saveFlickrImg:img withQuery:query];
                     [result addObject:img];
                 }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     successBlock(result);
                 });
             }
         }
             failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     failureBlock(error.localizedDescription);
                 });
         }];
    }
}

+(void)getImagesForUserID:(NSString *)userID andPage:(NSInteger)page WithSuccess:(void (^)(NSArray *))successBlock andFailure:(void (^)(NSString *))failureBlock {
    
    if ([[CachingManager sharedInstance] fetchFlickrsWithOwner:userID] && page == 1) {
        successBlock([[CachingManager sharedInstance] fetchFlickrsWithOwner:userID]);
    }
    else {
    
        NSString *stringURL = [NSString stringWithFormat:@"%@&api_key=%@&user_id=%@&page=%ld",BASE_URL,API_KEY,userID,(long)page];
        NSURL *url = [NSURL URLWithString:stringURL];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [manager GET:stringURL
          parameters:nil
             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                 
                 if (responseObject) {
                     
                     NSMutableArray *result = [NSMutableArray new];
                     
                     NSDictionary *dict = [responseObject objectForKey:@"photos"];
                     NSArray *photo = [dict objectForKey:@"photo"];
                     
                     for (NSDictionary *photoDict in photo) {
                         
                         FlickrImg *img = [[FlickrImg alloc] initWithDict:photoDict];
                         [[CachingManager sharedInstance] saveFlickrImg:img withOwner:userID];
                         [result addObject:img];
                     }
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         successBlock(result);
                     });
                 }
             }
             failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     failureBlock(error.localizedDescription);
                 });
             }];
    }
}

@end
