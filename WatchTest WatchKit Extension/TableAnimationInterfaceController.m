//
//  TableAnimationInterfaceController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/21.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "TableAnimationInterfaceController.h"
#import "RowController.h"
@interface TableAnimationInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@end

@implementation TableAnimationInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self.table setNumberOfRows:3 withRowType:@"RowController"];
    [self loadTableData];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)loadTableData{
    for (int i=0; i<self.table.numberOfRows; i++) {
        RowController * row = [self.table rowControllerAtIndex:i];
        [row.titleLabel setText:[NSString stringWithFormat:@"%d",i]];
    }
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)insertAction {
    [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withRowType:@"RowController"];
    [self loadTableData];

}
- (IBAction)deleteAction {
    if ([self.table numberOfRows]<=1) {
        return;
    }
    [self.table removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
    [self loadTableData];

}

@end



