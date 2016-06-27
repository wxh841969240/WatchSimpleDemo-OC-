//
//  WCManager.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/20.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "WCManager.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface WCManager ()<WCSessionDelegate>

@end

@implementation WCManager

+ (WCManager *)defaultManager{
    static WCManager * manager = nil;
    static dispatch_once_t once_Token = 0 ;
    if (!manager) {
        dispatch_once(&once_Token, ^{
            manager = [[WCManager alloc]init];
        });
    }
    return manager;
}
- (WCSession *)session{
    if (!_session) {
        if ([WCSession isSupported]) {
            _session = [WCSession defaultSession];
        }
        _session.delegate = self;
        [_session activateSession];
    }
    return _session;
}

- (BOOL)activeSession{
    if (![self.session isReachable]) {
        [self.session activateSession];
    }
    return YES;
}

#pragma mark - WatchOS 不可用回调

/**
 * 激活状态发生改变
 */

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error{
    NSLog(@"session:%@ activationDidCompleteWithState:%ld error:%@",session,(long)activationState,error);
}

/** ------------------------- iOS App State For Watch ------------------------ */

/**
 * 会话非活动
 */
- (void)sessionDidBecomeInactive:(WCSession *)session{
    NSLog(@"sessionDidBecomeInactive:%@",session);
}
/**
 * 会话被关闭了
 */
- (void)sessionDidDeactivate:(WCSession *)session{
    NSLog(@"sessionDidDeactivate:%@",session);
}
/**
 * 会话手表状态改变
 */
- (void)sessionWatchStateDidChange:(WCSession *)session{
    NSLog(@"sessionWatchStateDidChange:%@",session);
}

/** ------------------------- Interactive Messaging ------------------------- */

/**
 * 与watch对接状态发生改变
 */
- (void)sessionReachabilityDidChange:(WCSession *)session{
    NSLog(@"sessionReachabilityDidChange:%@",session);
}

/**
 * 收到一个不需要回调的NSDictionary消息
 */
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message{
    NSLog(@"session:%@didReceiveMessage:%@",session,message);
}

/**
 * 收到一个需要回调的NSDictionary消息
 */
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler{
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"收到来自手表的信息:%@",message[@"message"]] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:action];
    
    [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:alertController animated:YES completion:^{
    }];
    
    NSLog(@"session:%@didReceiveMessage:%@ replyHandler",session,message);
    replyHandler(@{@"reply":[NSString stringWithFormat:@"手机收到了信息:%@",message[@"message"]]});
}
/**
 * 收到一个不需要回调的NSData消息
 */
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData{
    NSLog(@"session:%@didReceiveMessageData:%@",session,messageData);

}

/**
 * 收到一个需要回调的NSData消息
 */
- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler{
    NSLog(@"session:%@didReceiveMessageData:%@ replyHandler",session,messageData);

}

/** -------------------------- Background Transfers ------------------------- */

/** 
 * 收到应用上下文，可以获取上个应用的活动状态，以配合上一个App的状态。即所谓的HandOff
 */
- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext{
    NSLog(@"session:%@ didReceiveApplicationContext:%@",session,applicationContext);
}

/** 
 * userInfo发送完毕回调，如果此时程序关闭，则会在程序下次启动时收到回调。
 */
- (void)session:(WCSession * __nonnull)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer *)userInfoTransfer error:(nullable NSError *)error{
    NSLog(@"session:%@ didFinishUserInfoTransfer:%@ error:%@",session,userInfoTransfer,error);
}

/** 
 * UserInfo接收完毕，如果此时程序关闭，则会在程序下次启动时收到回调。
 */
- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo{
    NSLog(@"session:%@ didReceiveUserInfo:%@",session,userInfo);
}

/**
 * 文件发送完毕回调，如果此时程序关闭，则会在程序下次启动时收到回调。
 */
- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error{
    
    NSLog(@"session:%@ didFinishFileTransfer:%@ error:%@",session,fileTransfer,error);
}

/** 
 * 文件接收完毕回调，如果此时程序关闭，则会在程序下次启动时收到回调。文件默认放在Documents/Inbox/中，需要在这里转移文件的位置，否则出了这个函数，文件将被清除
 */
- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file{
    NSLog(@"session:%@ didReceiveFile:%@",session,file);
}







@end
