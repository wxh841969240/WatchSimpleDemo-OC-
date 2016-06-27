//
//  DrawPathsInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "DrawPathsInterfaceController.h"
#import <UIKit/UIKit.h>
#import "PocketSVG.h"

@interface DrawPathsInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *contextImage;

@end

@implementation DrawPathsInterfaceController

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
- (IBAction)strokeAction {
    
    
    // Create a graphics context
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Setup for the path appearance
    CGContextSetStrokeColorWithColor(context, UIColor.whiteColor.CGColor);
    CGContextSetLineWidth(context, 4.0);
    
    // Draw lines
    CGContextBeginPath (context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextMoveToPoint(context, 0, 100);
    CGContextAddLineToPoint(context, 100, 0);
    CGContextStrokePath(context);
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    [self.contextImage setImage:image];
    UIGraphicsEndImageContext();
    
}
- (IBAction)bezerAction {
    
    // Create a graphics context
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Setup for the path appearance
    [UIColor.greenColor setStroke];
    [UIColor.whiteColor setFill];
    // Draw lines

    CGRect rect = CGRectMake(2, 2, 96, 96);
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    path.lineWidth = 4.0;
    [path fill];
    [path stroke];
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    [self.contextImage setImage:image];
    UIGraphicsEndImageContext();

    
}
- (IBAction)svgAction {
    
    // Create a graphics context
    CGSize size = CGSizeMake(512, 512);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Setup for the path appearance
    [UIColor.yellowColor setFill];

    // Convert SVG -> CGPath -> UIBezierPath
    PocketSVG * pocketSvg = [[PocketSVG alloc] initFromSVGFileNamed:@"sample"];
    UIBezierPath * path = pocketSvg.bezier;
    [path fill];

    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    [self.contextImage setImage:image];
    UIGraphicsEndImageContext();
    
    
}

@end



