//
//  AudioRecAndPlayInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "AudioRecAndPlayInterfaceController.h"

@interface AudioRecAndPlayInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *recLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *playLabel;

@end

@implementation AudioRecAndPlayInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (NSURL *)fileURL{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSURL * container = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.com.taofang.today"];
    return [container URLByAppendingPathComponent:@"rec.mp4"];
}

- (IBAction)recordAction {
    [self presentAudioRecorderControllerWithOutputURL:[self fileURL] preset:WKAudioRecorderPresetHighQualityAudio options:nil completion:^(BOOL didSave, NSError * _Nullable error) {
        [self.recLabel setText:[NSString stringWithFormat:@"didSave:(%d), error:%@",didSave,error]];
    }];
}
- (IBAction)playAction {
    [self presentMediaPlayerControllerWithURL:[self fileURL] options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        [self.playLabel setText:[NSString stringWithFormat:@"didPlayToEnd:%d, endTime:%lf, error:%@",didPlayToEnd,endTime,error]];
    }];
}

@end



