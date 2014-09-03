//
//  VONLoginViewController.m
//  AllAroundU
//
//  Created by Duri Abdurahman Duri on 8/14/14.
//  Copyright (c) 2014 Duri Duri. All rights reserved.
//

#import "VONLoginViewController.h"

@interface VONLoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *loginImageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;
@property (strong, nonatomic) NSMutableData *imageData;

- (IBAction)loginButtonPressed:(UIButton *)sender;

@end

@implementation VONLoginViewController

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
    self.loginActivityIndicator.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self updateUserInformation];
        [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    //Start the ActivityIndicator
    self.loginActivityIndicator.hidden = NO;
    [self.loginActivityIndicator startAnimating];
    
    
    //Choose Permissions
    NSArray *permissionsArray = @[@"public_profile",
                                  @"email",
                                  @"user_birthday",
                                  @"user_location",
                                  @"user_friends"];
    
    //Login Funcationality
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        [self.loginActivityIndicator stopAnimating];
        self.loginActivityIndicator.hidden = YES;
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"You cancelled the Facebook login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                NSString *S = [error localizedDescription];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:S delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        }
        else {
            NSLog(@"User with facebook logged in!");
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        }
    }];
    
    //Mixpanel Analytics
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Facebook Login"];
    [mixpanel flush];
}

#pragma mark - NSURL Data Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // As chuncks of the image are received, we build our data file
    [self.imageData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // All data has been downloaded, now we can set the image in the header image view
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    [self uploadPFFileToParse:profileImage];
}





#pragma mark - Helper Methods
-(void)updateUserInformation
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *)result;
            
            //Create URL
            NSString *facebookID = userDictionary[@"id"];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
            if (userDictionary[@"name"]) userProfile[kVONUserProfileNameKey] = userDictionary [@"name"];
            
            if (userDictionary[@"first_name"]) userProfile[kVONUserProfileFirstNameKey] = userDictionary[@"first_name"];
            
            if (userDictionary[@"location"][@"name"]) userProfile[kVONUserProfileLocation] = userDictionary[@"location"][@"name"];
            
            if (userDictionary[@"gender"]) userProfile[kVONUserProfileGender] = userDictionary[@"gender"];
            
            if (userDictionary[@"birthday"]){
                userProfile[kVONUserProfileBirthday] = userDictionary[@"birthday"];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterShortStyle];
                NSDate *date = [formatter dateFromString:userDictionary[@"birthday"]];
                NSDate *now = [NSDate date];
                NSTimeInterval seconds = [now timeIntervalSinceDate: date];
                int age = seconds / 31536000;
                //NSLog(@"%i", age);
                
                userProfile[kVONUserProfileAgeKey] = @(age);
            }
            
            if (userDictionary[@"interested_in"]) userProfile[kVONUserProfileInterestedIn] = userDictionary[@"interested_in"];
            
            if (userDictionary[@"relationship_status"])userProfile[kVONUserProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
            
            
            if ([pictureURL absoluteString]) userProfile[kVONUserProfilePictureURL] = [pictureURL absoluteString];
            
            [[PFUser currentUser] setObject:userProfile forKey:kVONUserProfileKey];
            [[PFUser currentUser] saveInBackground];
            [self requestImage];
        }
        else {
            NSLog(@"Error in Facebook Request %@", error);
        }
    }];
}


//Helper Method to upload a PFFFile (image to Parse
-(void)uploadPFFileToParse:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    if (!imageData) {
        NSLog(@"imageData was not found");
        return;
    }
    
    PFFile *photoFile = [PFFile fileWithData:imageData];
    
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            PFObject *photo = [PFObject objectWithClassName:kVONPhotoClassKey];
            [photo setObject:[PFUser currentUser] forKey:kVONPhotoUserKey];
            [photo setObject:photoFile forKey:kVONPhotoPictureKey];
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSLog(@"Photo saved successfully");
            }];
            
        }
    }];
}

//Helper method to get the current user's profile picture
- (void)requestImage
{
    
    PFQuery *query = [PFQuery queryWithClassName:kVONPhotoClassKey];
    [query whereKey:kVONPhotoUserKey equalTo:[PFUser currentUser]];
    //Use count instead
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        
        if (number == 0){
            PFUser *user = [PFUser currentUser];
            self.imageData = [[NSMutableData alloc] init];
            NSURL *profilePictureURL = [NSURL URLWithString:user[kVONUserProfileKey][kVONUserProfilePictureURL]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            
            // Run network request asynchronously
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            
            if (!urlConnection) NSLog(@"Failed to download picture");
        }
    }];
}

@end
