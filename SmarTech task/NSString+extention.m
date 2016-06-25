//
//  NSString+extention.m
//  Vibes
//
//  Created by islam metwally on 1/16/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "NSString+extention.h"

@implementation NSString (extention)

-(void) show:(id)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:self preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okay];
    [sender presentViewController:alert animated:YES completion:nil];
}

@end
