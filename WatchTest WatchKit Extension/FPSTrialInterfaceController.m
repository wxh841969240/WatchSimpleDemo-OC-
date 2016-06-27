//
//  FPSTrialInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "FPSTrialInterfaceController.h"

@interface FPSTrialInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *progressImage;

@end

@implementation FPSTrialInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self thirtySixFPS];
}
- (IBAction)thirtySixFPS {
    [self startAnimating:36];

}
- (IBAction)twentyFourFPS {
    [self startAnimating:24];
}

- (IBAction)twelveFPS {
    [self startAnimating:12];
}

- (void)startAnimating:(NSInteger)fps{
    
    [self.progressImage stopAnimating];

    NSMutableArray * images = [NSMutableArray array];
    
    for (int i=1; i<=fps; i++) {
        int index = 36 * i / fps ;
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"progress-%d",index]]];
    }
    
    [self.progressImage setImage:[UIImage animatedImageWithImages:images duration:2.0]];
    
    [self.progressImage startAnimating];
    
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    [self.progressImage stopAnimating];
}



@end
