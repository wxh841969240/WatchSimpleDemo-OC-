//
//  NSURLSessionInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "NSURLSessionInterfaceController.h"

@interface NSURLSessionInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *contentImage;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *progressGroup;

@property (nonatomic, strong) NSURLSessionDataTask * task;

@property (nonatomic, assign) BOOL isActivate;

@end

@implementation NSURLSessionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.isActivate = YES;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    self.isActivate = NO;

    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
    }
}

- (IBAction)startAction {
    NSURL * url = [NSURL URLWithString:@"https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/tam-ogel/cb908a3bc10f8bf0ff39d4d423979b88_121_121.jpg"];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    
    self.task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            UIImage * image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isActivate) {
                    [self.contentImage setImage:image];
                }
            });
        }
    }];
    
    [self.task resume];
}

@end
