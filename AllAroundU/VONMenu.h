//
//  VONMenu.h
//  Union
//
//  Created by Duri Abdurahman Duri on 8/6/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VONMenu : NSObject{
    NSMutableDictionary *menu;
}

@property (copy, nonatomic) NSMutableDictionary *menu;
@property (strong, nonatomic ) NSMutableArray *menuArray;
@property (strong, nonatomic) NSString *name;
+(NSMutableDictionary *)getMondayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getTuesdayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getWednesdayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getThursdayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getFridayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getSaturdayMenu:(NSString *)dinerURL;
+(NSMutableDictionary *)getSundayMenu:(NSString *)dinerURL;

@end
