//
//  ExtensionDelegate.h
//  WatchTest WatchKit Extension
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import <WatchKit/WatchKit.h>

#define ComplicationCurrentEntry    @"ComplicationCurrentEntry"
#define ComplicationShortTextData   @"ComplicationShortTextData"
#define ComplicationTextData        @"ComplicationTextData"

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>

@property (nonatomic, strong) NSMutableDictionary * myComplicationData;

@end
