//
//  CoordinatedAnimationsInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "CoordinatedAnimationsInterfaceController.h"

@interface CoordinatedAnimationsInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *progressGroup;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@property (nonatomic, strong) NSArray * items;

@end

@implementation CoordinatedAnimationsInterfaceController

- (NSArray *)items{
    if (!_items) {
        NSMutableArray * items = [NSMutableArray array];
        for (int i=0; i<37; i++) {
            WKPickerItem * item = [[WKPickerItem alloc]init];
            item.title = [NSString stringWithFormat:@"%d",i];
            [items addObject:item];
        }
        _items = [items copy];
    }
    return _items;
}


- (void)awakeWithContext:(id)context{
    [super awakeWithContext: context];
    [self.progressGroup setBackgroundImage:[UIImage imageNamed:@"progress-0"]];
    [self.picker setItems:self.items];
}

- (void)willActivate{
    [super willActivate];
}

- (void)didDeactivate{
    [super didDeactivate];
}
- (IBAction)scrollAction:(NSInteger)value {
    WKPickerItem * item = self.items[value];
    [self.progressGroup setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"progress-%@",item.title]]];
}

@end
