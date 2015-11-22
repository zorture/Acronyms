//
//  AcronymHeaderView.m
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/22/15.
//
//

#import "AcronymHeaderView.h"

@implementation AcronymHeaderView


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"AcronymHeaderView"
                                                          owner:self
                                                        options:nil];
        
        self = nibViews.firstObject;
    }
    return self;
}

@end
