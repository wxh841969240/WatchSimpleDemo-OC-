//
//  WCWatchManager.h
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface WCWatchManager : NSObject

@property (nonatomic, strong) WCSession * session;

+ (WCWatchManager *)defaultManager;

- (BOOL)activeSession;

@end
