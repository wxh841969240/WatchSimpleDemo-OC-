//
//  PedometerInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "PedometerInterfaceController.h"
#import <CoreMotion/CoreMotion.h>
@interface PedometerInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *stepsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *distanceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *ascendedLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *descendedLabel;

@property (nonatomic, strong) CMPedometer * pedometer;

@end

@implementation PedometerInterfaceController

- (CMPedometer *)pedometer{
    if (!_pedometer) {
        _pedometer = [[CMPedometer alloc]init];
    }
    return _pedometer;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if ([CMPedometer isPaceAvailable]) {
        __weak typeof (&*self) weakSelf = self;
        [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            [weakSelf.stepsLabel setText:[NSString stringWithFormat:@"%lu",pedometerData.numberOfSteps.unsignedLongValue]];
            [weakSelf.distanceLabel setText:[NSString stringWithFormat:@"%lu",pedometerData.distance.unsignedLongValue]];
            [weakSelf.ascendedLabel setText:[NSString stringWithFormat:@"%lu",pedometerData.floorsAscended.unsignedLongValue]];
            [weakSelf.descendedLabel setText:[NSString stringWithFormat:@"%lu",pedometerData.floorsDescended.unsignedLongValue]];
        }];
        
    }else{
        [self.stepsLabel setText:@"无法使用"];
        [self.distanceLabel setText:@"无法使用"];
        [self.ascendedLabel setText:@"无法使用"];
        [self.descendedLabel setText:@"无法使用"];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self.pedometer stopPedometerUpdates];
}

@end



