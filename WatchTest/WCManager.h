//
//  WCManager.h
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface WCManager : NSObject

@property (nonatomic, strong) WCSession * session;

+ (WCManager *)defaultManager;

- (BOOL)activeSession;

@end
