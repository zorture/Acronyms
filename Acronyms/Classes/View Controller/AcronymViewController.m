//
//  AcronymViewController.m
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import "AcronymViewController.h"
#import "AcronymBizAdapter.h"
#import "AcronymDataModel.h"
#import "MBProgressHUD.h"
#import "AcronymTableViewCell.h"
#import "AcronymHeaderView.h"

static NSString *CellIdentifier = @"headerView";

@interface AcronymViewController ()
@property (nonatomic, strong) AcronymBizAdapter* acronymBA;
@property (nonatomic, strong) NSArray* acronymMeaningArray;
@property (nonatomic, weak) NSIndexPath* expandCellPath;

@end

@implementation AcronymViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[AcronymHeaderView class] forHeaderFooterViewReuseIdentifier:CellIdentifier];
    self.acronymBA = [AcronymBizAdapter sharedAdapter];
}

- (void)getMeaningForAcronmy:(NSString*)string{
    [self.acronymBA requestMeaningForAcronym:string Success:^(NSArray *responseObject) {
        self.acronymMeaningArray = responseObject;
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } Failure:^(NSError *error) {
        NSLog(@"Some Issue");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return self.acronymMeaningArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AcronymTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AcronymDataModel* acronymDM = self.acronymMeaningArray[indexPath.row];
    [cell.meaningTextLbl setText:acronymDM.longForm];
    [cell setVariationArray:acronymDM.variationAr];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    AcronymHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    [headerView.searchBar setDelegate:self];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}

#pragma mark - Table view Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.expandCellPath = indexPath;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 50;

    if (self.expandCellPath != nil && indexPath.row == self.expandCellPath.row){
        AcronymDataModel* acronymDM = self.acronymMeaningArray[indexPath.row];
        height += acronymDM.variationAr.count*30;
    }
    
    return height;
}
 

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getMeaningForAcronmy:searchBar.text];
    self.acronymMeaningArray = nil;
    [self.tableView reloadData];
    
}

@end
