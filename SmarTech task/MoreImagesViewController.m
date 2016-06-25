//
//  MoreImagesViewController.m
//  SmarTech task
//
//  Created by islam metwally on 3/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "MoreImagesViewController.h"
#import "FlickrTableViewCell.h"

@interface MoreImagesViewController ()
{
    NSMutableArray *arrResults;
    NSInteger pageNumber;
    BOOL loading;
}
@end

@implementation MoreImagesViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    arrResults = [NSMutableArray new];
    pageNumber = 1;
    loading = 0;
    // Do any additional setup after loading the view.
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getMoreImgs];
}

-(void) successCommonScenario:(NSArray *)result {
    
    if (result && result.count) {
        if (pageNumber == 1 && result.count == 20)
            [arrResults removeAllObjects];
        
        //to check number of cached objects pages
        if (result.count > 20)
            pageNumber = result.count/20;
        
        [arrResults addObjectsFromArray:result];
        pageNumber++;
        [self.tableView reloadData];
    }
    else if (result && !result.count) {
        
        [@"No more images for the selected flickr user" show:self];
        loading = 1;
    }
}

-(void) getMoreImgs {
    loading = 1;
    [FlickrImg getImagesForUserID:_selectedFlickr.owner
                          andPage:pageNumber
                      WithSuccess:^(NSArray *results) {
                          
                          [self successCommonScenario:results];
                          loading = 0;
                      }
                       andFailure:^(NSString *error) {
                          
                           [error show:self];
                           loading = 0;
                      }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrResults.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    FlickrImg *flick = [arrResults objectAtIndex:indexPath.row];
    [cell setCellWithFlickr:flick];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - (scrollView.frame.size.height * 2) && !loading) {
        [self getMoreImgs];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
