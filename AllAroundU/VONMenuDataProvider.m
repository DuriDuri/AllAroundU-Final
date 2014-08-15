//
//  VONMenuDataProvider.m
//  Union
//
//  Created by Duri Abdurahman Duri on 8/3/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONMenuDataProvider.h"

@implementation VONMenuDataProvider


+(NSString *)getUpperDiningHallURL
{
    
    NSURL *menuURL = [NSURL URLWithString:@DINING_MENU_URL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *hall  = [doc searchWithXPathQuery:@"//div[@align='left']/p/a"];
    TFHppleElement *node = hall[0];
    NSString *urlExtension = [node objectForKey:@"href"];
    NSString *upperDiningHallURL = [NSString stringWithFormat:@"%@%@",@ROOT_DINING_URL, urlExtension];
    
    //NSLog(@"%@", [node objectForKey:@"href"]);
    
    return upperDiningHallURL;
}


+(NSString *)getWestDiningHallURL{
    NSURL *menuURL = [NSURL URLWithString:@DINING_MENU_URL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *hall  = [doc searchWithXPathQuery:@"//span[@class='style3']/a"];
    
    TFHppleElement *node = hall[0];
    NSString *urlExtension = [node objectForKey:@"href"];
    
    NSString *westDiningHallURL = [NSString stringWithFormat:@"%@%@",@ROOT_DINING_URL, urlExtension];
    

    
    return westDiningHallURL;
}

@end
