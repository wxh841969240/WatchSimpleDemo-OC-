//
//  HapticInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "HapticInterfaceController.h"

@interface HapticInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *hapticPicker;
@property (nonatomic, strong) NSArray * pickerItems;//UI
@property (nonatomic, strong) NSArray * haptics;//Data

@property (nonatomic, strong) WKPickerItem * currentItem;//UI
@property (nonatomic, strong) NSDictionary * currentInfo;//Data

@end

@implementation HapticInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.haptics = @[@{@"value":@(WKHapticTypeNotification),
                            @"title":@"Notification"},
                          @{@"value":@(WKHapticTypeDirectionUp),
                            @"title":@"DirectionUp"},
                          @{@"value":@(WKHapticTypeDirectionDown),
                            @"title":@"DirectionDown"},
                          @{@"value":@(WKHapticTypeSuccess),
                            @"title":@"Success"},
                          @{@"value":@(WKHapticTypeFailure),
                            @"title":@"Failure"},
                          @{@"value":@(WKHapticTypeRetry),
                            @"title":@"Retry"},
                          @{@"value":@(WKHapticTypeStart),
                            @"title":@"Start"},
                          @{@"value":@(WKHapticTypeStop),
                            @"title":@"Stop"},
                          @{@"value":@(WKHapticTypeClick),
                            @"title":@"Click"}];
    
    NSMutableArray * pickerItems = [NSMutableArray array];
    for (NSDictionary * hapticDict in self.haptics) {
        WKPickerItem * pickerItem = [[WKPickerItem alloc]init];
        pickerItem.title = hapticDict[@"title"];
        
        [pickerItems addObject:pickerItem];
    }
    
    
    self.pickerItems = [pickerItems copy];
    [self.hapticPicker setItems:self.pickerItems];
    
    
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
- (IBAction)didSelectedIndex:(NSInteger)index {
    
    self.currentItem = self.pickerItems[index];//UI
    self.currentInfo = self.haptics[index];//Data
    
}

- (IBAction)playAction{
    [[WKInterfaceDevice currentDevice] playHaptic:[self.currentInfo[@"value"] integerValue]];
    
}

@end



