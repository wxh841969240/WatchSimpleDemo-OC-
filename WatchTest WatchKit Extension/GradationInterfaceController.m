//
//  GradationInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/22.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "GradationInterfaceController.h"
#import <UIKit/UIKit.h>


@interface GradationInterfaceController ()
@property (nonatomic, weak) IBOutlet WKInterfaceImage *image;
@end


@implementation GradationInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}


// =============================================================================
#pragma mark - Actions

- (IBAction)linearBtnTapped:(id)sender {
    
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CFMutableArrayRef gradientColors = CFArrayCreateMutable(kCFAllocatorDefault, 2, &kCFTypeArrayCallBacks);
    CFArrayAppendValue(gradientColors, [UIColor greenColor].CGColor);
    CFArrayAppendValue(gradientColors, [UIColor blueColor].CGColor);
    
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(100, 100);
    
    CGFloat locations[2] = {
        0, 1
    };
    
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientColors, locations);
    CGContextDrawLinearGradient(context,
                                gradient,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsAfterEndLocation|kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CFRelease(gradientColors);
    CGContextRestoreGState(context);
    
    // Convert to UIImage
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    UIImage *uiimage = [UIImage imageWithCGImage:cgimage];
    
    // End the graphics context
    UIGraphicsEndImageContext();
    
    [self.image setImage:uiimage];
}

- (IBAction)radialBtnTapped:(id)sender {
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CFMutableArrayRef gradientColors = CFArrayCreateMutable(kCFAllocatorDefault, 2, &kCFTypeArrayCallBacks);
    CFArrayAppendValue(gradientColors, [UIColor greenColor].CGColor);
    CFArrayAppendValue(gradientColors, [UIColor blueColor].CGColor);
    
    CGPoint center = CGPointMake(50, 50);
    CGFloat locations[2] = {
        0, 1
    };
    
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), gradientColors, locations);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, sqrt(pow(50, 2) * 2), kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CFRelease(gradientColors);
    CGContextRestoreGState(context);
    
    // Convert to UIImage
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    UIImage *uiimage = [UIImage imageWithCGImage:cgimage];
    
    // End the graphics context
    UIGraphicsEndImageContext();
    
    [self.image setImage:uiimage];
}


@end
