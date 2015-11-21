//
//  AcronymDataModel.h
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import <Foundation/Foundation.h>

@interface AcronymDataModel : NSObject

@property (nonatomic, strong) NSString* shortForm;
@property (nonatomic, strong) NSString* longForm;
@property (nonatomic, strong) NSString* freq;
@property (nonatomic, strong) NSString* since;
@property (nonatomic, strong) NSArray* variationAr;

@end
