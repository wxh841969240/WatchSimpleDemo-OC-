//
//  PickerStylesInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "PickerStylesInterfaceController.h"

@interface PickerStylesInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *listPicker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *stackPicker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *sequencePicker;

@property (nonatomic, strong) NSArray * pickerItems;

@end

@implementation PickerStylesInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSMutableArray * pickerItems = [NSMutableArray array];
    
    for (int i=1 ;i<10;i++) {
        
        WKPickerItem * item = [[WKPickerItem alloc]init];
        
        NSString * imageNameString = [NSString stringWithFormat:@"m%d",i];
        WKImage * image = [WKImage imageWithImageName:imageNameString];
        item.contentImage = image;
        item.accessoryImage = image;
        item.title = imageNameString;
        item.caption = imageNameString;
        [pickerItems addObject:item];

    }
    self.pickerItems = [pickerItems copy];

    [self.listPicker setItems:self.pickerItems];
    [self.stackPicker setItems:self.pickerItems];
    [self.sequencePicker setItems:self.pickerItems];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



