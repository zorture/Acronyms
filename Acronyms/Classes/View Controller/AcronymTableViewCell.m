//
//  AcronymTableViewCell.m
//
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import "AcronymTableViewCell.h"
#import "VariationDataModel.h"

#define kCellIdentifier @"cellIdentifier"

@interface AcronymTableViewCell()

@property (weak, nonatomic) IBOutlet UICollectionView *acronymColView;
@end

@implementation AcronymTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setVariationArray:(NSArray *)variationArray{
    _variationArray = variationArray;
    [self.acronymColView reloadData];
}

#pragma mark - Collection view Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.variationArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AcronymCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    VariationDataModel* variationDM = self.variationArray[indexPath.row];
    [cell.variationTextLbl setText:variationDM.longForm];
    return cell;
    
}

@end

@interface AcronymCollectionViewCell()
@end

@implementation AcronymCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

@end

