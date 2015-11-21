//
//  AcronymTableViewCell.h
//
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import <UIKit/UIKit.h>

@interface AcronymTableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *meaningTextLbl;
@property (nonatomic, strong) NSArray* variationArray;;
@end


@interface AcronymCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *variationTextLbl;
@end
