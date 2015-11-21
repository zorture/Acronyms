//
//  AcronymBizAdapter.m
//  
//
//  Created by Kanwar Zorawar Singh Rana on 11/19/15.
//
//

#import "AcronymBizAdapter.h"
#import "AcronymDataModel.h"
#import "VariationDataModel.h"
#import "AFHTTPSessionManager.h"

@interface AcronymBizAdapter()

@property (nonatomic,strong) NSString* acronymSearchStr;
@property (nonatomic,strong) AcronymDataModel* acronymDM;
@property (nonatomic,strong) NSMutableSet* acronymSet;
@property (nonatomic,strong) AFHTTPSessionManager * requestManager;


@end

NSString * const kAcronymBaseURL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

NSString * const kSf = @"sf";
NSString * const kLfs = @"lfs";
NSString * const kLf = @"lf";
NSString * const kVars = @"vars";
NSString * const kFreq = @"freq";
NSString * const kSince = @"since";

@implementation AcronymBizAdapter

+ (id)sharedAdapter {
    static AcronymBizAdapter *sharedAdapter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAdapter = [[self alloc] init];
    });
    return sharedAdapter;
}

- (id)init {
    if (self = [super init]) {
        // Initialize the member objects
        self.acronymSet = [NSMutableSet new];
        
        // Creating Session Manger with base url and congigration.
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAcronymBaseURL] sessionConfiguration:configuration];
        self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)requestMeaningForAcronym:(NSString*)acronymString
                         Success:(void (^)(NSArray* responseObject))success
                         Failure:(void (^)(NSError *error))failure
{
    // Creating GET request
    [self.requestManager GET:[@"?sf=" stringByAppendingString:acronymString] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        // remove all previous objects for fresh search.
        [self.acronymSet removeAllObjects];
        
        // Parse the JSON response into Data Model
        for (id tempAcronymData in [[responseObject firstObject] objectForKey:kLfs])
        {
            
            NSMutableSet* tempVariationSet = [[NSMutableSet alloc] init];
            AcronymDataModel* acronymDM  = [[AcronymDataModel alloc] init];
            
            // Setting Data Model for Variation
            for(id tempVariationData in [tempAcronymData objectForKey:kVars]){
                VariationDataModel* variationDM = [VariationDataModel new];
                variationDM.longForm = [tempVariationData objectForKey:kLf];
                variationDM.freq = [tempVariationData objectForKey:kFreq];
                variationDM.since = [tempVariationData objectForKey:kSince];
                [tempVariationSet addObject:variationDM];
            }

            // Setting Data Model for acronym 
            acronymDM.longForm = [tempAcronymData objectForKey:kLf];
            acronymDM.freq = [tempAcronymData objectForKey:kFreq];
            acronymDM.since = [tempAcronymData objectForKey:kSince];
            acronymDM.variationAr= [tempVariationSet allObjects];
            [self.acronymSet addObject:acronymDM];
        }
        
        // returning final array.
        success([self.acronymSet allObjects]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}


- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
