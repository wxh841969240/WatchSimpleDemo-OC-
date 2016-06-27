//
//  ViewController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "ViewController.h"
#import "WCManager.h"
#import <HealthKit/HealthKit.h>

@interface ViewController ()
@property (nonatomic, weak) WCManager * manager;
@property (nonatomic, strong) HKHealthStore * healthStore;
@property (nonatomic, strong) HKQuantityType * heartRateType;
@property (nonatomic, strong) HKUnit * heartRateUnit;
@property (nonatomic, strong) HKQuery * heartRateQuery;
@end

@implementation ViewController

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



- (WCManager *)manager{
    if (!_manager) {
        _manager = [WCManager defaultManager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![HKHealthStore isHealthDataAvailable]) {
        return;
    }
    
    NSSet * dataTypes = [NSSet setWithObject:self.heartRateType];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:dataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            NSLog(@"用户不允许");
        }
    }];


}
- (IBAction)sendMessage:(id)sender {
    
    if (WCSession.isSupported) {
        [self.manager.session sendMessage:@{@"haha":@"hehe"} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",replyMessage] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            });
            NSLog(@"<iPhone> replyMessage:%@",replyMessage);
        } errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"<iPhone> sendError:%@",error);
        }];
        
    }
}

- (IBAction)sendMessageData:(id)sender {
    if (WCSession.isSupported) {
        [self.manager.session sendMessageData:[NSData data] replyHandler:^(NSData * _Nonnull replyMessageData) {
            NSLog(@"<iPhone> replyMessageData:%@",replyMessageData);
        } errorHandler:^(NSError * _Nonnull error) {
            NSLog(@"<iPhone> sendError:%@",error);
        }];
    }
}

- (IBAction)sendTransfer:(id)sender {
    if (WCSession.isSupported) {
        [self.manager.session transferUserInfo:@{@"userInfo":@"transfer"}];
    }
}

- (IBAction)sendFile:(id)sender {
    if (WCSession.isSupported) {
        NSFileManager * fm = [NSFileManager defaultManager];
        NSString * path = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
        Byte xx = 16;
        NSData * data = [NSData dataWithBytes:&xx length:10];
        if (![fm fileExistsAtPath:[NSString stringWithFormat:@"%@/testFile",path]]) {
            [fm createFileAtPath:[NSString stringWithFormat:@"%@/testFile",path] contents:data attributes:nil];
        }
        [self.manager.session transferFile:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/testFile",path]] metadata:@{@"test58":@"58"}];
    }
}
- (IBAction)updateComlications:(id)sender {
    if (WCSession.isSupported) {
        [self.manager.session transferCurrentComplicationUserInfo:@{@"userInfo":@"Complication"}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
