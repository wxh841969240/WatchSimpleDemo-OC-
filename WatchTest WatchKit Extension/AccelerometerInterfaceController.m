//
//  AccelerometerInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "AccelerometerInterfaceController.h"
#import <CoreMotion/CoreMotion.h>
@interface AccelerometerInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *x_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *y_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *z_label;

@property (nonatomic, strong) CMMotionManager * motionManager;

@end

@implementation AccelerometerInterfaceController

- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.1;

    }
    return _motionManager;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    
    
    // Configure interface objects here.
}

- (void)willActivate {
    if (self.motionManager.accelerometerAvailable) {
        __weak typeof(&*self) weakSelf = self;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            [weakSelf.x_label setText:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x]];
            [weakSelf.y_label setText:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y]];
            [weakSelf.z_label setText:[NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z]];
        }];
    }else{
        [self.x_label setText:@"无法使用"];
        [self.y_label setText:@"无法使用"];
        [self.z_label setText:@"无法使用"];
    }
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self.motionManager stopAccelerometerUpdates];

}

@end



