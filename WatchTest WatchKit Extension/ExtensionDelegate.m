//
//  ExtensionDelegate.m
//  WatchTest WatchKit Extension
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "WCWatchManager.h"
#import "InterfaceController.h"
#import <UserNotifications/UserNotifications.h>
#import <ClockKit/ClockKit.h>

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    WCWatchManager * manager = [WCWatchManager defaultManager];
    [manager session];
    [self myComplicationData];
    
    
    NSArray * activeComplications = [CLKComplicationServer sharedInstance].activeComplications;

    for (CLKComplication * complication in activeComplications) {
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>%ld",(long)complication.family);
        
        CLKComplicationFamily family = complication.family;
        
////        if (complication.family == CLKComplicationFamilyModularLarge) {
//            //该方法最多可以被调用50次每天
//            [[CLKComplicationServer sharedInstance] reloadTimelineForComplication:complication];
////        }
    }
    
    
    // Perform any final initialization of your application.
}

- (NSMutableDictionary *)myComplicationData{
    if (!_myComplicationData) {
        _myComplicationData = [@{ComplicationCurrentEntry:@{
                                ComplicationShortTextData:@"短",
                                ComplicationTextData:@"内容"}}
                               mutableCopy];
    }
    return _myComplicationData;
}


- (void)handleBackgroundTasks:(NSSet<WKRefreshBackgroundTask *> *)backgroundTasks{
    for (WKSnapshotRefreshBackgroundTask * task in backgroundTasks) {
        
    
        if ([task isKindOfClass:[WKSnapshotRefreshBackgroundTask class]]) {
            NSLog(@">>>>>>>>>>>>>WKSnapshotRefreshBackgroundTask<<<<<<<<<<<<<<<");
            [self performSelectorOnMainThread:@selector(prepareSnapeToken) withObject:nil waitUntilDone:YES];
            [task setTaskCompletedWithDefaultStateRestored:YES estimatedSnapshotExpiration:[NSDate date] userInfo:nil];
            continue;
        }
        [task setTaskCompleted];
        
    }
}

- (void)prepareSnapeToken{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSnapeShotRefreshNotificationPath object:nil];
}





- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

@end
