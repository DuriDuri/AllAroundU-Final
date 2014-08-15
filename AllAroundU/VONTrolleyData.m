//
//  VONTrolleyData.m
//  Union
//
//  Created by Duri Abdurahman Duri on 7/31/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONTrolleyData.h"

@implementation VONTrolleyData
@synthesize title,subtitle, coordinate;


+(NSDate *)getCurrentTime
{
    NSDate *currentTime = [[NSDate alloc] init];
    //self.time = currentTime;
    return currentTime;
}

+(float)getLongitude
{
    NSURL *trolleyURL = [[NSURL alloc] initWithString:@TROLLEY_URL];
    NSString *htmlData = [[NSString alloc] initWithContentsOfURL:trolleyURL encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *parsedComments = [htmlData componentsSeparatedByString:@"<!--"];
    NSString *coordinatesA = parsedComments[3];
    NSArray *parsedCoordinates = [coordinatesA componentsSeparatedByString:@":"];
    
    NSString *coordinates = parsedCoordinates[1];
    NSArray *A = [coordinates componentsSeparatedByString:@";"];
    
    NSString *longitudeA = A[0];
    float longitude= [longitudeA floatValue];
    
    return longitude;
}

+(float)getLatitude
{
    NSURL *trolleyURL = [[NSURL alloc] initWithString:@TROLLEY_URL];
    NSString *htmlData = [[NSString alloc] initWithContentsOfURL:trolleyURL encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *parsedComments = [htmlData componentsSeparatedByString:@"<!--"];
    NSString *coordinatesA = parsedComments[3];
    NSArray *parsedCoordinates = [coordinatesA componentsSeparatedByString:@":"];
    
    NSString *coordinates = parsedCoordinates[1];
    NSArray *A = [coordinates componentsSeparatedByString:@";"];
    
    NSString *longitudeA = A[1];
    float latitude= [longitudeA floatValue];
    
    return latitude;
}

+(CLLocationCoordinate2D)getCoordinates
{
    NSURL *trolleyURL = [[NSURL alloc] initWithString:@TROLLEY_URL];
    NSString *htmlData = [[NSString alloc] initWithContentsOfURL:trolleyURL encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *parsedComments = [htmlData componentsSeparatedByString:@"<!--"];
    NSString *coordinatesA = parsedComments[3];
    NSArray *parsedCoordinates = [coordinatesA componentsSeparatedByString:@":"];
    
    NSString *coordinates = parsedCoordinates[1];
    NSArray *A = [coordinates componentsSeparatedByString:@";"];
    
    NSString *latitudeA = A[1];
    float latitude= [latitudeA floatValue];
    float longitude = [A[0] floatValue];

    CLLocationCoordinate2D trolley = CLLocationCoordinate2DMake(longitude, latitude);
    return trolley;
}

@end
