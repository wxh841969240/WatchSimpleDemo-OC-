//
//  InterfaceController.m
//  WatchTest WatchKit Extension
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "InterfaceController.h"
#import "WBTestRow.h"

static NSString * const kItemKeyTitle = @"title";
static NSString * const kItemKeyDetail = @"detail";
static NSString * const kItemKeyClassPrefix = @"prefix";

@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSArray * items;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tookSnapeShot:) name:kSnapeShotRefreshNotificationPath object:nil];
    
    
    [self loadRow];
    
    
    // Configure interface objects here.
}

- (NSArray *)items{
    if (!_items) {
        _items = @[
                   @{kItemKeyTitle:@"SceneKit",
                     kItemKeyDetail:@"SceneKit",
                     kItemKeyClassPrefix:@"SceneKit"},
                   @{kItemKeyTitle:@"表冠",
                     kItemKeyDetail:@"现在可以直接使用表冠来做交互",
                     kItemKeyClassPrefix:@"Crown"},
                   @{kItemKeyTitle:@"NSURLSession",
                     kItemKeyDetail:@"利用NSURLSession下载一张图片",
                     kItemKeyClassPrefix:@"NSURLSession"},
                   @{kItemKeyTitle:@"帧动画",
                     kItemKeyDetail:@"36帧、24帧、12帧进度条动画",
                     kItemKeyClassPrefix:@"FPSTrial"},
                   @{kItemKeyTitle:@"消息传递",
                     kItemKeyDetail:@"给手机发送一条消息",
                     kItemKeyClassPrefix:@"MessageToPhone"},
                   @{kItemKeyTitle:@"调起系统App",
                     kItemKeyDetail:@"通过调用系统的URL去调起系统的App",
                     kItemKeyClassPrefix:@"OpenSystemURL"},
                   @{kItemKeyTitle:@"数字表冠",
                     kItemKeyDetail:@"通过picker控件使用表冠的一个实例",
                     kItemKeyClassPrefix:@"CoordinatedAnimations"},
                   @{kItemKeyTitle:@"动画属性",
                     kItemKeyDetail:@"宽高、透明度、平移",
                     kItemKeyClassPrefix:@"AnimatedProperties"},
                   @{kItemKeyTitle:@"Table动画",
                     kItemKeyDetail:@"行插入与移除动画",
                     kItemKeyClassPrefix:@"TableAnimation"},
                   @{kItemKeyTitle:@"Picker",
                     kItemKeyDetail:@"Picker的样式简单介绍",
                     kItemKeyClassPrefix:@"PickerStyles"},
                   @{kItemKeyTitle:@"触觉引擎",
                     kItemKeyDetail:@"各种触觉反馈音效播放",
                     kItemKeyClassPrefix:@"Haptic"},
                   @{kItemKeyTitle:@"录音与播放",
                     kItemKeyDetail:@"录音播放录音",
                     kItemKeyClassPrefix:@"AudioRecAndPlay"},
                   @{kItemKeyTitle:@"加速器",
                     kItemKeyDetail:@"显示x、y、z轴值",
                     kItemKeyClassPrefix:@"Accelerometer"},
                   @{kItemKeyTitle:@"陀螺仪",
                     kItemKeyDetail:@"显示x、y、z轴值",
                     kItemKeyClassPrefix:@"Gyroscope"},
                   @{kItemKeyTitle:@"设备动作",
                     kItemKeyDetail:@"显示x、y、z轴值",
                     kItemKeyClassPrefix:@"DeviceMotion"},
                   @{kItemKeyTitle:@"计步器",
                     kItemKeyDetail:@"步数、距离、上楼梯、下楼梯",
                     kItemKeyClassPrefix:@"Pedometer"},
                   @{kItemKeyTitle:@"划线",
                     kItemKeyDetail:@"划线、贝塞尔、svg",
                     kItemKeyClassPrefix:@"DrawPaths"},
                   @{kItemKeyTitle:@"心率",
                     kItemKeyDetail:@"helthKit心率检测",
                     kItemKeyClassPrefix:@"HeartRate"},
                   @{kItemKeyTitle:@"颜色渐变效果",
                     kItemKeyDetail:@"包含线性渐变与放射渐变效果",
                     kItemKeyClassPrefix:@"Gradation"},
                   @{kItemKeyTitle:@"音频播放",
                     kItemKeyDetail:@"播放音频文件的控件",
                     kItemKeyClassPrefix:@"AudioFilePlayer"},
                   @{kItemKeyTitle:@"提示框",
                     kItemKeyDetail:@"手表上的提示框",
                     kItemKeyClassPrefix:@"Alert"}
                   ];
    }
    return _items;
}

- (void)loadRow{
    [self.table setNumberOfRows:self.items.count withRowType:@"WBTestRow"];
    for (int i=0;i<self.items.count;i++) {
        WBTestRow * row = [self.table rowControllerAtIndex:i];
        [row.titleLabel setText:self.items[i][kItemKeyTitle]];
        [row.descLabel setText:self.items[i][kItemKeyDetail]];
        
        NSLog(@"%@", self.items[i][kItemKeyDetail]);
        
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    NSDictionary * itemDict = self.items[rowIndex];

    [self pushControllerWithName:[NSString stringWithFormat:@"%@InterfaceController",itemDict[kItemKeyClassPrefix]] context:nil];
}

- (void)tookSnapeShot:(NSNotification *)notification{
    [self popToRootController];
    [self pushControllerWithName:[NSString stringWithFormat:@"FPSTrialInterfaceController"] context:nil];
}



//- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex{
//    return @{};
//}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
}

@end



