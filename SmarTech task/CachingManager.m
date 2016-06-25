//
//  CachingManager.m
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "AppDelegate.h"
#import "CachingManager.h"

@implementation CachingManager

+(id) sharedInstance {
    
    static CachingManager *sharedInstance;
    if (sharedInstance == nil) {
        sharedInstance = [[CachingManager alloc] init];
    }
    return sharedInstance;
}

-(void) saveFlickrImg:(FlickrImg *)flickr withQuery:(NSString *)searchString {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    
    NSManagedObject *flickrImgContext = [NSEntityDescription insertNewObjectForEntityForName:@"FlickrImg"
                                                               inManagedObjectContext:context];
    [flickrImgContext setValue:flickr.title forKey:@"title"];
    [flickrImgContext setValue:flickr.imgID forKey:@"id"];
    [flickrImgContext setValue:flickr.server forKey:@"server"];
    [flickrImgContext setValue:flickr.farm forKey:@"farm"];
    [flickrImgContext setValue:flickr.owner forKey:@"owner"];
    [flickrImgContext setValue:flickr.secret forKey:@"secret"];
    
    [flickrImgContext setValue:searchString forKey:@"searchString"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(NSArray *) fetchFlickrsWithQuery:(NSString *)searchString {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"FlickrImg"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        
        NSArray *keys = [[[info entity] attributesByName] allKeys];
        NSDictionary *dict = [info dictionaryWithValuesForKeys:keys];
        
        if ([searchString isEqualToString:[info valueForKey:@"searchString"]]) {
            
            FlickrImg *img = [[FlickrImg alloc] initWithDict:dict];
            [results addObject:img];
        }
    }
    if (results.count) {
        return (NSArray *)results;
    }
    return nil;
}

-(NSArray *) fetchFlickrsWithOwner:(NSString *)owner {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"FlickrImg"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        
        NSArray *keys = [[[info entity] attributesByName] allKeys];
        NSDictionary *dict = [info dictionaryWithValuesForKeys:keys];
        
        if ([owner isEqualToString:[info valueForKey:@"owner"]]) {
            
            FlickrImg *img = [[FlickrImg alloc] initWithDict:dict];
            [results addObject:img];
        }
    }
    if (results.count) {
        return (NSArray *)results;
    }
    return nil;
}

-(void) saveFlickrImg:(FlickrImg *)flickr withOwner:(NSString *)owner {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    
    NSManagedObject *flickrImgContext = [NSEntityDescription insertNewObjectForEntityForName:@"FlickrImg"
                                                                      inManagedObjectContext:context];
    [flickrImgContext setValue:flickr.title forKey:@"title"];
    [flickrImgContext setValue:flickr.imgID forKey:@"id"];
    [flickrImgContext setValue:flickr.server forKey:@"server"];
    [flickrImgContext setValue:flickr.farm forKey:@"farm"];
    [flickrImgContext setValue:flickr.owner forKey:@"owner"];
    [flickrImgContext setValue:flickr.secret forKey:@"secret"];
    
    [flickrImgContext setValue:@"" forKey:@"searchString"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
