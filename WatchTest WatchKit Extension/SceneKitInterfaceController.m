//
//  SenceKitInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/28.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "SceneKitInterfaceController.h"
#import <SceneKit/SceneKit.h>
@interface SceneKitInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSCNScene *senceKitSence;

@end


@implementation SceneKitInterfaceController
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self sceneSetup];

}

- (void)sceneSetup{
    
    SCNScene * scene = [[SCNScene alloc] init];
    SCNBox * boxGeometry = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:1.0];
    SCNNode * node = [SCNNode nodeWithGeometry:boxGeometry];
    [scene.rootNode addChildNode:node];
    self.senceKitSence.scene = scene;
    
}


- (IBAction)firstAction {
    
    
    self.senceKitSence.autoenablesDefaultLighting = !self.senceKitSence.autoenablesDefaultLighting;

}
- (IBAction)secondAction {
    SCNVector4 vector = self.senceKitSence.scene.rootNode.rotation;
    vector.w += M_PI/20.0;
    vector.x = 1;
    vector.y = 0;
    vector.z = 0;
    self.senceKitSence.scene.rootNode.rotation = vector;
}
- (IBAction)thirdAction {
    SCNVector4 vector = self.senceKitSence.scene.rootNode.rotation;
    vector.w += M_PI/20.0;
    vector.y = 1;
    vector.x = 0;
    vector.z = 0;
    self.senceKitSence.scene.rootNode.rotation = vector;
}
- (IBAction)fourthAction {
    SCNVector4 vector = self.senceKitSence.scene.rootNode.rotation;
    vector.w += M_PI/20.0;
    vector.x = 0;
    vector.y = 0;
    vector.z = 1;
    self.senceKitSence.scene.rootNode.rotation = vector;
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
@end
