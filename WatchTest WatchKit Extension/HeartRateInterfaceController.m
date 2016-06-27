//
//  HeartRateInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "HeartRateInterfaceController.h"
#import <HealthKit/HealthKit.h>
@interface HeartRateInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *actionButton;


@property (nonatomic, strong) HKHealthStore * healthStore;
@property (nonatomic, strong) HKQuantityType * heartRateType;
@property (nonatomic, strong) HKUnit * heartRateUnit;
@property (nonatomic, strong) HKQuery * heartRateQuery;

@end

@implementation HeartRateInterfaceController

- (HKHealthStore *)healthStore{
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}

- (HKQuantityType *)heartRateType{
    if (!_heartRateType) {
        _heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    }
    return _heartRateType;
}

- (HKUnit *)heartRateUnit{
    if (!_heartRateUnit) {
        _heartRateUnit = [HKUnit unitFromString:@"count/min"];
    }
    return _heartRateUnit;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if (![HKHealthStore isHealthDataAvailable]) {
        [self.label setText:@"无法使用"];
        return;
    }
    
    NSSet * dataTypes = [NSSet setWithObject:self.heartRateType];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            [self.label setText:@"用户不允许"];
        }
    }];
    
    
    // Configure interface objects here.
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self.healthStore stopQuery:self.heartRateQuery];

}
- (IBAction)action {
    if (self.heartRateQuery == nil) {
        self.heartRateQuery = [self createStreamingQuery];
        [self.healthStore executeQuery:self.heartRateQuery];
        [self.actionButton setTitle:@"Stop"];
    }else{
        [self.healthStore stopQuery:self.heartRateQuery];
        [self.actionButton setTitle:@"Start"];
        self.heartRateQuery = nil;
        
    }
}

- (HKQuery *)createStreamingQuery{
    
    NSPredicate * predicate = [HKQuery predicateForSamplesWithStartDate:[NSDate date] endDate:nil options:HKQueryOptionNone];
    __weak typeof(&*self) weakSelf = self;
    HKAnchoredObjectQuery * query = [[HKAnchoredObjectQuery alloc] initWithType:self.heartRateType
                                                        predicate:predicate
                                                           anchor:nil
                                                            limit:HKObjectQueryNoLimit
                                                   resultsHandler:^(HKAnchoredObjectQuery * _Nonnull query,
                                                                    NSArray<__kindof HKSample *> * _Nullable sampleObjects,
                                                                    NSArray<HKDeletedObject *> * _Nullable deletedObjects,
                                                                    HKQueryAnchor * _Nullable newAnchor,
                                                                    NSError * _Nullable error) {
        [weakSelf addSamples:sampleObjects];
    }];
    [query setUpdateHandler:^(HKAnchoredObjectQuery * _Nonnull query,
                              NSArray<__kindof HKSample *> * _Nullable sampleObjects,
                              NSArray<HKDeletedObject *> * _Nullable deletedObjects,
                              HKQueryAnchor * _Nullable newAnchor,
                              NSError * _Nullable error) {
        [weakSelf addSamples:sampleObjects];
    }];
    
    return query;
}

- (void)addSamples:(NSArray *)samples{
    HKQuantity * quantity = ((HKQuantitySample *)[samples lastObject]).quantity ;
    [self.label setText:[NSString stringWithFormat:@"%lf",[quantity doubleValueForUnit:self.heartRateUnit]]];
}




@end



