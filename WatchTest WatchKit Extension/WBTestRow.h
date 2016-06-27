//
//  WBTestRow.h
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface WBTestRow : NSObject

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *descLabel;

@end
