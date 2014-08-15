//
//  VONMenu.m
//  Union
//
//  Created by Duri Abdurahman Duri on 8/6/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONMenu.h"
#import "TFHpple.h"
@implementation VONMenu

@synthesize menu = _menu;
@synthesize menuArray = _menuArray;


+(NSMutableDictionary *)getMondayMenu:(NSString *)dinerURL{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='monday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='monday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='monday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}

+(NSMutableDictionary *)getTuesdayMenu:(NSString *)dinerURL
{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='tuesday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='tuesday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='tuesday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}


+(NSMutableDictionary *)getWednesdayMenu:(NSString *)dinerURL{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='wednesday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='wednesday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='wednesday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}


+(NSMutableDictionary *)getThursdayMenu:(NSString *)dinerURL
{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='thursday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='thursday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='thursday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}

+(NSMutableDictionary *)getFridayMenu:(NSString *)dinerURL
{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='friday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='friday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='friday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}


+(NSMutableDictionary *)getSaturdayMenu:(NSString *)dinerURL
{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='saturday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='saturday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='saturday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}


+(NSMutableDictionary *)getSundayMenu:(NSString *)dinerURL{
    NSURL *menuURL = [NSURL URLWithString:dinerURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *breakfastMenu = [doc searchWithXPathQuery:@"//td[@id='sunday']/table[@class='dayinner']/tr[@class='brk']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *lunchMenu = [doc searchWithXPathQuery:@"//td[@id='sunday']/table[@class='dayinner']/tr[@class='lun']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    NSArray *dinnerMenu = [doc searchWithXPathQuery:@"//td[@id='sunday']/table[@class='dayinner']/tr[@class='din']/td[@class='menuitem']/div[@class='menuitem']/span[@class='ul']"];
    
    NSMutableDictionary *menu = [[NSMutableDictionary alloc] init];
    
    if (breakfastMenu)[menu setValue:breakfastMenu forKey:kVONBreakfastKey];
    if (lunchMenu)[menu setValue:lunchMenu forKey:kVONLunchKey];
    if (dinnerMenu)[menu setValue:dinnerMenu forKey:kVONDinnerKey];
    
    return menu;
}

@end
