//
//  ComplicationController.m
//  WatchTest
//
//  Created by 王晓晖 on 16/6/23.
//  Copyright © 2016年 58tongcheng. All rights reserved.
//

#import "ComplicationController.h"
#import <ClockKit/ClockKit.h>
#import "ExtensionDelegate.h"
#import <SceneKit/SceneKit.h>
@interface ComplicationController ()<CLKComplicationDataSource>

@end

@implementation ComplicationController

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler{
    
    handler(CLKComplicationTimeTravelDirectionNone);
}


- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication
                                   withHandler:(void(^)(CLKComplicationTimelineEntry *))handler {
    // Get the current complication data from the extension delegate.
    ExtensionDelegate* myDelegate = (ExtensionDelegate*)[[WKExtension sharedExtension] delegate];
    NSDictionary* data = [myDelegate.myComplicationData objectForKey:ComplicationCurrentEntry];
    
    CLKComplicationTimelineEntry* entry = nil;
    NSDate* now = [NSDate date];
    
    // Create the template and timeline entry.
    if (complication.family == CLKComplicationFamilyModularSmall) {
        CLKComplicationTemplateModularSmallSimpleText* textTemplate =
        [[CLKComplicationTemplateModularSmallSimpleText alloc] init];
        textTemplate.textProvider = [CLKSimpleTextProvider
                                     textProviderWithText:[data objectForKey:ComplicationTextData]
                                     shortText:[data objectForKey:ComplicationShortTextData]];
        
        // Create the entry.
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:textTemplate];
    }
    else if(complication.family == CLKComplicationFamilyModularLarge){

        CLKComplicationTemplateModularLargeTallBody * textTemplate = [[CLKComplicationTemplateModularLargeTallBody alloc] init];
        textTemplate.headerTextProvider = [CLKSimpleTextProvider
                                           textProviderWithText:@"头部"];
        textTemplate.bodyTextProvider = [CLKSimpleTextProvider textProviderWithText:@"身1体"];
    
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:textTemplate];

    }else if(complication.family == CLKComplicationFamilyUtilitarianSmall){
        
        CLKComplicationTemplateUtilitarianSmallSquare * imageTemplate = [[CLKComplicationTemplateUtilitarianSmallSquare alloc] init];
        imageTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"progress-15"]];
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:imageTemplate];
        
    }else if (complication.family == CLKComplicationFamilyUtilitarianSmallFlat){
        
        CLKComplicationTemplateUtilitarianSmallFlat * imageTemplate = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
        
        imageTemplate.textProvider = [CLKSimpleTextProvider
                                      textProviderWithText:@"SFlat"];
        imageTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"progress-15"]];
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:imageTemplate];
        
    }else if (complication.family == CLKComplicationFamilyUtilitarianLarge){
        
        CLKComplicationTemplateUtilitarianLargeFlat * imageTemplate = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
        
        imageTemplate.textProvider = [CLKSimpleTextProvider
                                      textProviderWithText:@"SFlat"];
        imageTemplate.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[UIImage imageNamed:@"progress-15"]];
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:imageTemplate];
        
        
    }else if (complication.family == CLKComplicationFamilyCircularSmall){
        
        
        CLKComplicationTemplateCircularSmallSimpleText* textTemplate =
        [[CLKComplicationTemplateCircularSmallSimpleText alloc] init];
        textTemplate.textProvider = [CLKSimpleTextProvider
                                     textProviderWithText:[data objectForKey:ComplicationTextData]
                                     shortText:[data objectForKey:ComplicationShortTextData]];
        
        // Create the entry.
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:textTemplate];
        
    }else if (complication.family == CLKComplicationFamilyExtraLarge){
        
        
        CLKComplicationTemplateExtraLargeSimpleText* textTemplate =
        [[CLKComplicationTemplateExtraLargeSimpleText alloc] init];
        textTemplate.textProvider = [CLKSimpleTextProvider
                                     textProviderWithText:[data objectForKey:ComplicationTextData]
                                     shortText:[data objectForKey:ComplicationShortTextData]];
        
        // Create the entry.
        entry = [CLKComplicationTimelineEntry entryWithDate:now
                                       complicationTemplate:textTemplate];
        
        
    }

    // Pass the timeline entry back to ClockKit.
    handler(entry);
}


- (void)getLocalizableSampleTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler{
    // Get the current complication data from the extension delegate.
    
    
    // Create the template and timeline entry.
    if (complication.family == CLKComplicationFamilyModularSmall) {
        CLKComplicationTemplateModularSmallSimpleText* textTemplate =
        [[CLKComplicationTemplateModularSmallSimpleText alloc] init];
        textTemplate.textProvider = [CLKSimpleTextProvider
                                     textProviderWithText:@"内容"
                                     shortText:@"标"];
        handler(textTemplate);
    }
    else if(complication.family == CLKComplicationFamilyModularLarge){
        CLKComplicationTemplateModularLargeTallBody * textTemplate = [[CLKComplicationTemplateModularLargeTallBody alloc] init];
        textTemplate.headerTextProvider = [CLKSimpleTextProvider
                                           textProviderWithText:@"头样板"];
        textTemplate.bodyTextProvider = [CLKSimpleTextProvider textProviderWithText:@"身体样板"];
        handler(textTemplate);
    }
    
    // Pass the timeline entry back to ClockKit.
    handler(nil);
}

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler{
    // Get the current complication data from the extension delegate.
    
    
    // Create the template and timeline entry.
    if (complication.family == CLKComplicationFamilyModularSmall) {
        CLKComplicationTemplateModularSmallSimpleText* textTemplate =
        [[CLKComplicationTemplateModularSmallSimpleText alloc] init];
        textTemplate.textProvider = [CLKSimpleTextProvider
                                     textProviderWithText:@"内容"
                                     shortText:@"标"];
        handler(textTemplate);
    }
    else if(complication.family == CLKComplicationFamilyModularLarge){
        CLKComplicationTemplateModularLargeTallBody * textTemplate = [[CLKComplicationTemplateModularLargeTallBody alloc] init];
        textTemplate.headerTextProvider = [CLKSimpleTextProvider
                                           textProviderWithText:@"头样板"];
        textTemplate.bodyTextProvider = [CLKSimpleTextProvider textProviderWithText:@"身体样板"];
        handler(textTemplate);
    }
    
    // Pass the timeline entry back to ClockKit.
    handler(nil);
}



@end
