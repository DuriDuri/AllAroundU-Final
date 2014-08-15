//
//  VONTrolleyData.h
//  Union
//
//  Created by Duri Abdurahman Duri on 7/31/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface VONTrolleyData : NSObject <MKAnnotation>{

    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



+(float)getLongitude;
+(float)getLatitude;
+(CLLocationCoordinate2D)getCoordinates;
+(NSDate *)getCurrentTime;

@end
