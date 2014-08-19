//
//  VONLaundryDataProvider.m
//  Union
//
//  Created by Duri Abdurahman Duri on 8/12/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONLaundryDataProvider.h"
#import "TFHpple.h"
@implementation VONLaundryDataProvider




+(NSMutableDictionary *)getLaundryData:(NSString *)laundryRoomURL
{
    NSURL *menuURL = [NSURL URLWithString:laundryRoomURL];
    NSData  * data      = [NSData dataWithContentsOfURL:menuURL];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *machines = [doc searchWithXPathQuery:@"//span[@class='stat']"];
    
    NSMutableArray *washingMachines = [[NSMutableArray alloc] init];
    NSMutableArray *dryingMachines = [[NSMutableArray alloc] init];
    
    
    //Pull out Washing machines
    for (int i =0; i < machines.count /2 ; i++) {
        TFHppleElement *washer = machines[i];
        NSString *state = [washer text];
        NSString *formatedStateString = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [washingMachines addObject:formatedStateString];
    }
    
    //Extract Dryers
    for (int i = (int)machines.count /2; i < [machines count] ; i++) {
        TFHppleElement *dryer = machines[i];
        NSString *state = [dryer text];
        NSString *formatedStateString = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [dryingMachines addObject:formatedStateString];
    }
    
    
    //Combine into a dictionary
    NSMutableDictionary *laundryStatus = [[NSMutableDictionary alloc]init];
    [laundryStatus setValue:washingMachines forKey:@"Washing Machines"];
    [laundryStatus setValue:dryingMachines forKey:@"Dryers"];
    
    return laundryStatus;
    
}
@end
