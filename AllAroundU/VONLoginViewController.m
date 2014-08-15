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
}
@end
