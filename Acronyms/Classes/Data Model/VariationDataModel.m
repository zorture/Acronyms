//
//  VariationDataModel.m
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/20/15.
//
//

#import "VariationDataModel.h"

@implementation VariationDataModel

- (id)initWithCoder:(NSCoder *)decoder  {
    self = [super init];
    if (self) {
        self.longForm = [decoder decodeObjectForKey:@"longForm"];
        self.freq = [decoder decodeObjectForKey:@"freq"];
        self.since = [decoder decodeObjectForKey:@"since"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.longForm forKey:@"longForm"];
    [encoder encodeObject:self.freq forKey:@"freq"];
    [encoder encodeObject:self.since forKey:@"since"];
}



@end
