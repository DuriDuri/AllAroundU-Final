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
@property (strong, nonatomic) IBOutlet UITableView *washerTableView;
@property (strong, nonatomic) IBOutlet UITableView *dryerTableView;

@property (strong, nonatomic) NSMutableDictionary *laundryDetails;

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
        self.washerTableView.delegate = self;
        self.washerTableView.dataSource = self;
        
        self.dryerTableView.delegate = self;
        self.dryerTableView.dataSource = self;
        
        //NSLog(@"%@", self.detailedLaundryRoomURL);
        
        self.laundryDetails = [VONLaundryDataProvider getLaundryData:self.detailedLaundryRoomURL];
        NSLog(@"%@", self.laundryDetails);
        
        if ([[self.laundryDetails objectForKey:@"Washing Machines"] count] ==0  ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Settings"
                                                            message:@"To insure student privacy, please connect to the internet through ResNet or the Union network!" delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
            NSLog(@"Empty List");
            [alert show];
        }
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
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.washerTableView]) {
        static NSString *washerCells = @"WasherCells";
        UITableViewCell *washerCell = [self.washerTableView dequeueReusableCellWithIdentifier:washerCells forIndexPath:indexPath];
        washerCell.textLabel.text = [self.laundryDetails objectForKey:@"Washing Machines"][indexPath.row];
        
        
        
        return washerCell;
    }
    else {
        static NSString *dryerCells = @"DryerCells";
        UITableViewCell *dryerCell = [self.dryerTableView dequeueReusableCellWithIdentifier:dryerCells forIndexPath:indexPath];
        dryerCell.textLabel.text = [self.laundryDetails objectForKey:@"Dryers"][indexPath.row];
        
        return dryerCell;
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.washerTableView]) return [[self.laundryDetails objectForKey:@"Washing Machines"]count];
    else return [[self.laundryDetails objectForKey:@"Dryers"]count];
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.washerTableView ]) return @"Washing Machines";
    else if ([tableView isEqual:self.dryerTableView ]) return @"Dryers";
    else return @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender {
    [self viewDidLoad];
    [self.dryerTableView reloadData];
    [self.washerTableView reloadData];
}
@end
