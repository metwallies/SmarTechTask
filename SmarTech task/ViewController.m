//
//  ViewController.m
//  SmarTech task
//
//  Created by islam metwally on 3/30/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "ViewController.h"
#import "FlickrTableViewCell.h"
#import "MoreImagesViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UISearchBar *srchTxtField;
    __weak IBOutlet UITableView *tblViewReults;
    __weak IBOutlet UILabel *lblNoResults; // Enter words to search about || No resuts
    NSMutableArray *arrResults;
    BOOL loading;
    NSInteger pageNumber;
}
@end

@implementation ViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    pageNumber = 1;
    loading = 0;
    arrResults = [NSMutableArray new];
#ifdef Black
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.title = @"BLACK VERSION";
#endif
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) successCommonScenario:(NSArray *)result {
    
    if (result && result.count) {
        if (pageNumber == 1 && result.count == 20)
            [arrResults removeAllObjects];
        
        //to check number of cached objects pages
        pageNumber = result.count/20;
        
        lblNoResults.hidden = YES;
        tblViewReults.hidden = NO;
        [arrResults addObjectsFromArray:result];
        pageNumber++;
        [tblViewReults reloadData];
    }
    else if (result && !result.count) {
        
        tblViewReults.hidden = YES;
        lblNoResults.hidden = NO;
        lblNoResults.text = @"No Results";
    }
}

-(void) searchWithString:(NSString *) query {
    loading = 1;
    [FlickrImg getImagesWithSearchString:query
                                 andPage:pageNumber
                             WithSuccess:^(NSArray *results) {
                                 
                                 loading = 0;
                                 [self successCommonScenario:results];
                                 
                             } andFailure:^(NSString *error) {
                                 
                                 loading = 0;
                                 [error show:self];
                             }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrResults.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlickrTableViewCell *cell = (FlickrTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    FlickrImg *flickr = [arrResults objectAtIndex:indexPath.row];
    [cell setCellWithFlickr:flickr];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlickrImg *flick = [arrResults objectAtIndex:indexPath.row];
    MoreImagesViewController *moreImgsVC = [self.storyboard instantiateViewControllerWithIdentifier:MORE_IMAGES_STORYBOARD_ID];
    moreImgsVC.selectedFlickr = flick;
    [self showViewController:moreImgsVC sender:self];
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - (scrollView.frame.size.height * 2) && !loading) {
        [self searchWithString:srchTxtField.text];
    }
}

#pragma mark - UISearchBarDelegate

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    if (searchBar.text.length) {
        pageNumber = 1;
        [self searchWithString:searchBar.text];
    }
    else {
        [self successCommonScenario:nil];
        [lblNoResults setText:@"Please insert words to search"];
    }
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [self searchWithString:searchBar.text];
}

@end
