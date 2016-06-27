//
//  CrownInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/23.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "CrownInterfaceController.h"

@interface CrownInterfaceController ()<WKCrownDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *progressImage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;
@property (nonatomic, assign) NSInteger progressValue;
@end

@implementation CrownInterfaceController
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.progressValue = 0;
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.crownSequencer.delegate = self;
    NSLog(@"%@",self.crownSequencer);
    
}
- (IBAction)foucesAction {
    [self.crownSequencer focus];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)crownDidRotate:(nullable WKCrownSequencer *)crownSequencer rotationalDelta:(double)rotationalDelta{
    
    if (rotationalDelta>0) {
        if (self.progressValue<36) {
            self.progressValue ++;
        }else{
            return;
        }
    }else{
        if (self.progressValue>0) {
            self.progressValue --;
        }else{
            return;
        }
    }
    
    [self.progressImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"progress-%d",self.progressValue]]];
    
    NSLog(@"crownDidRotate>>%@:%lf",crownSequencer,rotationalDelta);
}
// called when the crown becomes idle
- (void)crownDidBecomeIdle:(nullable WKCrownSequencer *)crownSequencer{
    NSLog(@"crownDidBecomeIdle>>%@",crownSequencer);
}



@end
