//
//  VONFirstViewController.m
//  Union
//
//  Created by Duri Abdurahman Duri on 7/30/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONFirstViewController.h"
#import "TFHpple.h"
#import "VONMenuDataProvider.h"
#import "VONLaundryDataProvider.h"

@interface VONFirstViewController ()<MKMapViewDelegate>

- (IBAction)mapTerrainSC:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *terainSegmentedControl;

@property (strong, nonatomic) NSTimer *updateLocation;

- (IBAction)updateUserLocationButtonPressed:(UIButton *)sender;


@end

@implementation VONFirstViewController

-(VONTrolleyData *)trolley{
    if (!_trolley) _trolley = [[VONTrolleyData alloc] init];

    return _trolley;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.trolleyMapView.delegate = self;
    
    ///// UNCOMMENT LATER
    
    //Set Map Region
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0,0.0}};
    region.center.latitude = 42.817743;
    region.center.longitude = -73.930522;
    region.span.latitudeDelta = 0.018f;
    region.span.longitudeDelta = 0.018f;

    [self.trolleyMapView setRegion:region animated:YES];
    [self.trolleyMapView setShowsUserLocation:YES];
    
    [self addTrolleyPath];

    //Update Trolley Location
    self.updateLocation = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateTrolleyLocation) userInfo:nil repeats:YES];
    
    //Laundry TEST
    
    
///div[@class='menuitem']/span[@class='ul']
}

-(void)viewDidAppear:(BOOL)animated
{
    //Set Pin Details
    self.trolley.title = @"Trolley Location";
    self.trolley.subtitle = @"Union College";
    
    //Update Trolley Location
    [self updateTrolleyLocation];
    
    //Add pin to map
    [self.trolleyMapView addAnnotation:self.trolley];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - IBActions

- (IBAction)mapTerrainSC:(UISegmentedControl *)sender {
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            self.trolleyMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.trolleyMapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.trolleyMapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

- (IBAction)updateUserLocationButtonPressed:(UIButton *)sender {
    self.trolleyMapView.showsUserLocation = YES;
    CLLocationCoordinate2D userLocation = self.trolleyMapView.userLocation.coordinate;
    MKCoordinateRegion userRegion = MKCoordinateRegionMakeWithDistance(userLocation, 500, 500);
    [self.trolleyMapView setRegion:userRegion animated:YES];
}


#pragma mark - Helper Methods

-(void)addTrolleyPath
{
    CLLocationCoordinate2D  points[53];
    
    points[0] = CLLocationCoordinate2DMake(42.8207575,-73.9340094);
    points[1] = CLLocationCoordinate2DMake(42.8210723,-73.9338968);
    points[2] = CLLocationCoordinate2DMake(42.8207142,-73.9313648);
    points[3] = CLLocationCoordinate2DMake(42.8193741,-73.9335901);
    points[4] = CLLocationCoordinate2DMake(42.8170968,-73.9351604);
    points[5] = CLLocationCoordinate2DMake(42.8164692,-73.9335204);
    points[6] = CLLocationCoordinate2DMake(42.8174807,-73.93281);
    points[7] = CLLocationCoordinate2DMake(42.8175931,-73.9331319);
    points[8] = CLLocationCoordinate2DMake(42.8186604,-73.9324231);
    points[9] = CLLocationCoordinate2DMake(42.8185581,-73.9320369);
    points[10] = CLLocationCoordinate2DMake(42.8195497,-73.931243);
    points[11] = CLLocationCoordinate2DMake(42.8197071,-73.9307885);
    points[12] = CLLocationCoordinate2DMake(42.819589, -73.929958);
    points[13] = CLLocationCoordinate2DMake(42.8203582,-73.9294577);
    points[14] = CLLocationCoordinate2DMake(42.8199057,-73.9270169);
    points[15] = CLLocationCoordinate2DMake(42.8193345,-73.9268679);
    points[16] = CLLocationCoordinate2DMake(42.8188852,-73.9266141);
    points[17] = CLLocationCoordinate2DMake(42.8184836,-73.9271182);
    points[18] = CLLocationCoordinate2DMake(42.8183029,-73.9274269);
    points[19] = CLLocationCoordinate2DMake(42.8179785,-73.9278532);
    points[20] = CLLocationCoordinate2DMake(42.8181037,-73.9281213);
    points[21] = CLLocationCoordinate2DMake(42.8182925,-73.9278155);
    points[22] = CLLocationCoordinate2DMake(42.8179785,-73.9278532);
    points[23] = CLLocationCoordinate2DMake(42.8183029,-73.9274269);
    points[24] = CLLocationCoordinate2DMake(42.8184836,-73.9271182);
    points[25] = CLLocationCoordinate2DMake(42.8188852,-73.9266141);
    points[26] = CLLocationCoordinate2DMake(42.8193345,-73.9268679);
    points[27] = CLLocationCoordinate2DMake(42.8199327,-73.926936);
    points[28] = CLLocationCoordinate2DMake(42.8201294,-73.9231487);
    points[29] = CLLocationCoordinate2DMake(42.8200734,-73.9224866);
    points[30] = CLLocationCoordinate2DMake(42.8189946,-73.9226741);
    points[31] = CLLocationCoordinate2DMake(42.8181316,-73.9231408);
    points[32] = CLLocationCoordinate2DMake(42.8167872,-73.9243907);
    points[33] = CLLocationCoordinate2DMake(42.8154449,-73.9253053);
    points[34] = CLLocationCoordinate2DMake(42.8151524,-73.9273519);
    points[35] = CLLocationCoordinate2DMake(42.8155321,-73.9274182);
    points[36] = CLLocationCoordinate2DMake(42.8156737,-73.9279441);
    points[37] = CLLocationCoordinate2DMake(42.8154619,-73.9283088);
    points[38] = CLLocationCoordinate2DMake(42.8152651,-73.9300791);
    points[39] = CLLocationCoordinate2DMake(42.8155239,-73.9311315);
    points[40] = CLLocationCoordinate2DMake(42.8164413,-73.9305334);
    points[41] = CLLocationCoordinate2DMake(42.8165756,-73.9304744);
    points[42] = CLLocationCoordinate2DMake(42.8165032,-73.9303001);
    points[43] = CLLocationCoordinate2DMake(42.8163964,-73.9305683);
    points[44] = CLLocationCoordinate2DMake(42.8146708,-73.9317297);
    points[45] = CLLocationCoordinate2DMake(42.8159362,-73.9364192);
    points[46] = CLLocationCoordinate2DMake(42.8161448,-73.9388053);
    points[47] = CLLocationCoordinate2DMake(42.8206895,-73.9361968);
    points[48] = CLLocationCoordinate2DMake(42.8210988,-73.936347);
    points[49] = CLLocationCoordinate2DMake(42.8215196,-73.9357001);
    points[50] = CLLocationCoordinate2DMake(42.8212863,-73.9341379);
    points[51] = CLLocationCoordinate2DMake(42.8209027,-73.9343978);
    points[52] = CLLocationCoordinate2DMake(42.8206488,-73.934143);
    
    MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:53];
    poly.title = @"Trolley Route";
    
    [self.trolleyMapView addOverlay:poly];
}


-(void)updateTrolleyLocation
{
    self.trolley.coordinate = [VONTrolleyData getCoordinates];
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    UIColor * garnetColor = [UIColor colorWithRed:139/255.0f green:24/255.0f blue:26/255.0f alpha:1.0f];
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonView* aView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay] ;
        //aView.fillColor = [garnetColor colorWithAlphaComponent:0.2];
        aView.strokeColor = [garnetColor colorWithAlphaComponent:0.7];
        aView.lineWidth = 9;
        
        return aView;
    }
    
    return nil;
}



@end
