//
//  AcronymBizAdapter.h
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import <Foundation/Foundation.h>

@interface AcronymBizAdapter : NSObject

+ (id)sharedAdapter;
- (void)requestMeaningForAcronym:(NSString*)acronymString
                         Success:(void (^)(NSArray* responseObject))success
                         Failure:(void (^)(NSError *error))failure;

@end
