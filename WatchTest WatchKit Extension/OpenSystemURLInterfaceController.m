//
//  OpenSystemURLInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "OpenSystemURLInterfaceController.h"

@interface OpenSystemURLInterfaceController ()

@end

@implementation OpenSystemURLInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)phoneAction {
    [[WKExtension sharedExtension] openSystemURL:[NSURL URLWithString:@"tel:"]];
}
- (IBAction)smsAction {
    [[WKExtension sharedExtension] openSystemURL:[NSURL URLWithString:@"sms:"]];

}

@end
