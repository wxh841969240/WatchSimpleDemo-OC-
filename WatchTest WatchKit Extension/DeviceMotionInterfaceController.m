//
//  DeviceMotionInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "DeviceMotionInterfaceController.h"
#import <CoreMotion/CoreMotion.h>
@interface DeviceMotionInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *x_acc_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *y_acc_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *z_acc_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *x_gyr_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *y_gyr_label;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *z_gyr_label;
@property (nonatomic, strong) CMMotionManager * motionManager;

@end

@implementation DeviceMotionInterfaceController

- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.gyroUpdateInterval = 0.1;
        
    }
    return _motionManager;
}


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if (self.motionManager.deviceMotionAvailable){
        __weak typeof(&*self) weakSelf = self;
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            [weakSelf.x_acc_label setText:[NSString stringWithFormat:@"%.2f",motion.userAcceleration.x]];
            [weakSelf.y_acc_label setText:[NSString stringWithFormat:@"%.2f",motion.userAcceleration.y]];
            [weakSelf.z_acc_label setText:[NSString stringWithFormat:@"%.2f",motion.userAcceleration.z]];
            [weakSelf.x_gyr_label setText:[NSString stringWithFormat:@"%.2f",motion.rotationRate.x]];
            [weakSelf.y_gyr_label setText:[NSString stringWithFormat:@"%.2f",motion.rotationRate.y]];
            [weakSelf.z_gyr_label setText:[NSString stringWithFormat:@"%.2f",motion.rotationRate.z]];
            
        }];
        
    }else{
        
        [self.x_acc_label setText:@"无法使用"];
        [self.y_acc_label setText:@"无法使用"];
        [self.z_acc_label setText:@"无法使用"];
        [self.x_gyr_label setText:@"无法使用"];
        [self.y_gyr_label setText:@"无法使用"];
        [self.z_gyr_label setText:@"无法使用"];
    }
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self.motionManager stopDeviceMotionUpdates];
    
}

@end



