//
//  VONLaundryDataProvider.h
//  Union
//
//  Created by Duri Abdurahman Duri on 8/12/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VONLaundryDataProvider : NSObject


+(NSMutableDictionary *)getLaundryData:(NSString *)laundryRoomURL;

@end
