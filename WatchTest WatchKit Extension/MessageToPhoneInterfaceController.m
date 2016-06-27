//
//  MessageToPhoneInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "MessageToPhoneInterfaceController.h"

#import "WCWatchManager.h"

@interface MessageToPhoneInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *messagePicker;
@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) WKPickerItem * currentItem;

@end

@implementation MessageToPhoneInterfaceController
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self.messagePicker setItems:self.items];
    [self.messagePicker setSelectedItemIndex:0];
    self.currentItem = [self.items firstObject];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (NSArray *)items{
    if (!_items) {
        NSArray * messages = @[@"今天天气怎么样？",@"吃饭了吗？",@"你好",@"呵呵",@"嘿嘿",@"哈哈",@"新年快乐！"];
        NSMutableArray * items = [NSMutableArray new];
        for (NSString * message in messages) {
            WKPickerItem * item = [[WKPickerItem alloc]init];
            item.title = message;
            [items addObject:item];
        }
        _items = [items copy];
    }
    return _items;
}

- (IBAction)scrollAction:(NSInteger)value {
    self.currentItem = self.items[value];
}
- (IBAction)sendAction {
    if ([[WCWatchManager defaultManager].session isReachable]) {
        [[WCWatchManager defaultManager].session sendMessage:@{@"message":self.currentItem.title} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
           dispatch_async(dispatch_get_main_queue(), ^{
               WKAlertAction * cancelAction = [WKAlertAction actionWithTitle:@"取消" style:WKAlertActionStyleCancel handler:^{}];
               [self presentAlertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"收到回复:%@",replyMessage[@"reply"]] preferredStyle:WKAlertControllerStyleAlert actions:@[cancelAction]];
           });
        } errorHandler:^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WKAlertAction * cancelAction = [WKAlertAction actionWithTitle:@"取消" style:WKAlertActionStyleCancel handler:^{}];
                [self presentAlertControllerWithTitle:@"提示" message:@"发送错误" preferredStyle:WKAlertControllerStyleAlert actions:@[cancelAction]];
            });
        }];
    }else{
        WKAlertAction * cancelAction = [WKAlertAction actionWithTitle:@"取消" style:WKAlertActionStyleCancel handler:^{}];
        [self presentAlertControllerWithTitle:@"提示" message:@"无法连接到手机" preferredStyle:WKAlertControllerStyleAlert actions:@[cancelAction]];
    }
    
    
}
@end
