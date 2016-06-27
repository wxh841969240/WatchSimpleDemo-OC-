//
//  AudioFilePlayerInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "AudioFilePlayerInterfaceController.h"
#import <Foundation/Foundation.h>
@interface AudioFilePlayerInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *descLabel;
@property (nonatomic, strong) WKAudioFileQueuePlayer * audioPlayer;

@end

@implementation AudioFilePlayerInterfaceController

- (WKAudioFileQueuePlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"se_tap" ofType:@"m4a"];
        NSURL * fileURL = [NSURL fileURLWithPath:filePath];
        WKAudioFileAsset * asset = [WKAudioFileAsset assetWithURL:fileURL];
        WKAudioFilePlayerItem * playerItem = [WKAudioFilePlayerItem playerItemWithAsset:asset];
        _audioPlayer = [WKAudioFileQueuePlayer queuePlayerWithItems:@[playerItem]];
        NSLog(@"%@",_audioPlayer);
    }
    return _audioPlayer;
}


- (void)awakeWithContext:(id)context{
    [super awakeWithContext:context];
}

- (void)willActivate{
    [super willActivate];
}

- (void)didDeactivate{
    [super didDeactivate];
}
- (IBAction)playAction {
    [self audioPlayer];
    switch (self.audioPlayer.status) {
        case WKAudioFilePlayerStatusReadyToPlay:
            [self.descLabel setText:@"播放中..."];
            [self.audioPlayer play];
            break;
        case WKAudioFilePlayerStatusFailed:
            [self.descLabel setText:@"播放失败"];
            break;
        case WKAudioFilePlayerStatusUnknown:
            [self.descLabel setText:@"未知"];
            break;
            
        default:
            break;
    }
    
    
}

@end
