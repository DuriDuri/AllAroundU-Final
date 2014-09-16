//
//  VONLaundryDetailViewController.m
//  Union
//
//  Created by Duri Abdurahman Duri on 8/12/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONLaundryDetailViewController.h"
#import "VONLaundryDataProvider.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface VONLaundryDetailViewController ()
@property (strong, nonatomic) IBOutlet UITableView *laundryStatusTableView;
//@property (strong, nonatomic) IBOutlet UITableView *dryerTableView;

@property (strong, nonatomic) NSMutableDictionary *laundryDetails;
@property (strong, nonatomic) NSMutableArray *dryerStatus;
@property (strong, nonatomic) NSMutableArray *washerStatus;


- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender;
@end

@implementation VONLaundryDetailViewController

//Check internet connection
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![self connected])
    {
        // not connected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Not Found"
                                                        message:@"Please check your network settings!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        self.laundryStatusTableView.delegate = self;
        self.laundryStatusTableView.dataSource = self;
        
        
        //NSLog(@"%@", self.detailedLaundryRoomURL);
        
        self.laundryDetails = [VONLaundryDataProvider getLaundryData:self.detailedLaundryRoomURL];
        //NSLog(@"%@", self.laundryDetails);
        
        if ([[self.laundryDetails objectForKey:@"Washing Machines"] count] ==0  ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Settings"
                                                            message:@"To insure student privacy, please connect to the internet through ResNet or the Union network!" delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
            //NSLog(@"Empty List");
            [alert show];
        }
        //Mixpanel Analytics
        Mixpanel *mixpanel = [Mixpanel sharedInstance];
        [mixpanel track:@"Open Detailed Laundry Tracker"];
        [mixpanel flush];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *washerCells = @"StatusCell";
    UITableViewCell *statusCell = [self.laundryStatusTableView dequeueReusableCellWithIdentifier:washerCells forIndexPath:indexPath];

    if (indexPath.section == 0){
        statusCell.imageView.image = [UIImage imageNamed:@"WashingMachineIcon"];
        statusCell.textLabel.text = [self.laundryDetails objectForKey:@"Washing Machines"][indexPath.row];
    }
    if (indexPath.section == 1){
        statusCell.imageView.image = [UIImage imageNamed:@"DryerIcon"];
        statusCell.textLabel.text = [self.laundryDetails objectForKey:@"Dryers"][indexPath.row];
    }
    
        
    return statusCell;

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return [[self.laundryDetails objectForKey:@"Washing Machines"]count];
    else return [[self.laundryDetails objectForKey:@"Dryers"]count];
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) return @"Washing Machines";
    else if (section == 1) return @"Dryers";
    else return @"";
}



- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender {
    [self viewDidLoad];
    [self.laundryStatusTableView reloadData];
    
    //Mixpanel Analytics
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Refresh Laundry"];
    [mixpanel flush];
}
@end
