//
//  VONMenuViewController.m
//  Union
//
//  Created by Duri Abdurahman Duri on 8/9/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONMenuViewController.h"
#import "VONMenuDataProvider.h"
#import "TFHpple.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface VONMenuViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)diningHallSC:(UISegmentedControl *)sender;
- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender;

//Todays Date
@property (strong, nonatomic) NSString *dayToday;
//Selected Menu
@property (strong, nonatomic) NSMutableDictionary *todaysMenu;
//Menu Options
@property (strong, nonatomic) NSMutableDictionary *upperMenu;
@property (strong, nonatomic) NSMutableDictionary *westMenu;

//Menu Options
@property (strong, nonatomic) NSString *upperDiningHallURL;
@property (strong, nonatomic) NSString *westDiningHallURL;

@end

@implementation VONMenuViewController

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
    else
    {
        // connected, do some internet stuff
        
        //TableView instances
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        //Calculate the day
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"EEEE"];
        self.dayToday = [dateFormatter stringFromDate:[NSDate date]];
        //NSLog(@"%@", self.dayToday);
        
        
        //Define URL variables
        self.upperDiningHallURL = [VONMenuDataProvider getUpperDiningHallURL];
        self.westDiningHallURL = [VONMenuDataProvider getWestDiningHallURL];
        
        
        //Define custom diningHall dictionaries based of DOFTW
        if ([self.dayToday isEqualToString:@"Monday"]) {
            self.upperMenu = [VONMenu getMondayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getMondayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Tuesday"]) {
            self.upperMenu = [VONMenu getTuesdayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getTuesdayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Wednesday"]) {
            self.upperMenu = [VONMenu getWednesdayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getWednesdayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Thursday"]) {
            self.upperMenu = [VONMenu getThursdayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getThursdayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Friday"]) {
            self.upperMenu = [VONMenu getFridayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getFridayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Saturday"]) {
            self.upperMenu = [VONMenu getSaturdayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getSaturdayMenu:self.westDiningHallURL];
        }
        if ([self.dayToday isEqualToString:@"Sunday"]) {
            self.upperMenu = [VONMenu getSundayMenu:self.upperDiningHallURL];
            self.westMenu = [VONMenu getSundayMenu:self.westDiningHallURL];
        }
        
        //Initialize todays Menu
        self.todaysMenu = self.upperMenu;
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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section ==0){
        TFHppleElement *meal = [self.todaysMenu objectForKey:kVONBreakfastKey][indexPath.row];
        cell.textLabel.text =[meal text];
    }
    if (indexPath.section ==1) cell.textLabel.text =[[self.todaysMenu objectForKey:kVONLunchKey][indexPath.row] text];
    if (indexPath.section ==2) cell.textLabel.text =[[self.todaysMenu objectForKey:kVONDinnerKey][indexPath.row] text];

    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return [[self.todaysMenu objectForKey:kVONBreakfastKey] count];
    if (section == 1) return [[self.todaysMenu objectForKey:kVONLunchKey] count];
    if (section == 2) return [[self.todaysMenu objectForKey:kVONDinnerKey] count];
    return 15;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0 && [[self.todaysMenu objectForKey:kVONBreakfastKey] count] ) return @"BreakFast";
    if (section == 1 && [[self.todaysMenu objectForKey:kVONLunchKey] count]) return @"Lunch";
    if (section == 2 && [[self.todaysMenu objectForKey:kVONDinnerKey] count]) return @"Dinner";
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




- (IBAction)diningHallSC:(UISegmentedControl *)sender {
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            self.todaysMenu = self.upperMenu;
            [self.tableView reloadData];
            break;
        case 1:
            self.todaysMenu = self.westMenu;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender {
    [self viewDidLoad];
}
@end
