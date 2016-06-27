//
//  AlertInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "AlertInterfaceController.h"

@interface AlertInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *tipLabel;


@end

@implementation AlertInterfaceController

- (void)awakeWithContext:(id)context{
    [super awakeWithContext: context];
}

- (void)willActivate{
    [super willActivate];
}

- (void)didDeactivate{
    [super didDeactivate];
}
- (IBAction)alert {
    [self showAlertControllerWithStyle:WKAlertControllerStyleAlert];
}
- (IBAction)alertWithSideBySideButtons {
    [self showAlertControllerWithStyle:WKAlertControllerStyleSideBySideButtonsAlert];
}
- (IBAction)actionSheet {
    [self showAlertControllerWithStyle:WKAlertControllerStyleActionSheet];
}
- (void)showAlertControllerWithStyle:(WKAlertControllerStyle)style{
    //bateSDK内点击事件好像没有效果。
    __weak typeof(&*self) weakSelf = self;
    WKAlertAction * defaultAction = [WKAlertAction actionWithTitle:@"默认" style:WKAlertActionStyleDefault handler:^{
        [weakSelf.tipLabel setText:@"默认"];
    }];
    
    WKAlertAction * cancelAction = [WKAlertAction actionWithTitle:@"取消" style:WKAlertActionStyleCancel handler:^{
        [weakSelf.tipLabel setText:@"取消"];
    }];
    
    WKAlertAction * destructiveAction = [WKAlertAction actionWithTitle:@"销毁" style:WKAlertActionStyleDestructive handler:^{
        [weakSelf.tipLabel setText:@"销毁"];
    }];
    
    NSMutableArray * actions = [@[defaultAction,destructiveAction] mutableCopy];
    
    if (style!=WKAlertControllerStyleSideBySideButtonsAlert) {
        [actions addObject:cancelAction];
    }
    [self presentAlertControllerWithTitle:@"标题" message:@"内容" preferredStyle:style actions:actions];
}



@end
