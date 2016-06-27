//
//  AnimatedPropertiesInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "AnimatedPropertiesInterfaceController.h"

@interface AnimatedPropertiesInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *zombie;

@end

@implementation AnimatedPropertiesInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)scaleAction {
    [self animateWithDuration:0.5 animations:^{
        [self.zombie setHeight:160];
        [self.zombie setWidth:100];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:0.5 animations:^{
            [self.zombie setHeight:80];
            [self.zombie setWidth:50];
        }];
    });
}

- (IBAction)alphaAction {
    [self animateWithDuration:0.5 animations:^{
        [self.zombie setAlpha:0];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:0.5 animations:^{
            [self.zombie setAlpha:1];
        }];
    });
}

- (IBAction)positionAction {
    
    [self animateWithDuration:0.5 animations:^{
        [self.zombie setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentRight];
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:0.2 animations:^{
            [self.zombie setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentLeft];
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:1 animations:^{
            [self.zombie setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentCenter];
        }];
    });
    
}

@end



