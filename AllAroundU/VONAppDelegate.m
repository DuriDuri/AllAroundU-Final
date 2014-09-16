//
//  VONAppDelegate.m
//  AllAroundU
//
//  Created by Duri Abdurahman Duri on 8/14/14.
//  Copyright (c) 2014 Duri Duri. All rights reserved.
//

#import "VONAppDelegate.h"

@implementation VONAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Navigation Bar and Title Color
    UIColor * garnetColor = [UIColor colorWithRed:139/255.0f green:24/255.0f blue:26/255.0f alpha:1.0f]; //8E151E
    UIColor * yellowColor = [UIColor colorWithRed:255/255.0f green:210/255.0f blue:99/255.0f alpha:1.0f]; //FFD263
    [[UINavigationBar appearance] setBarTintColor:garnetColor];
    [[UINavigationBar appearance] setTintColor:yellowColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: yellowColor}];
    
    //Set Tab Bar Tint
    [[UITabBar appearance] setTintColor:yellowColor];
    
    
    
    
    //Parse Integration
    [Parse setApplicationId:@"NHM8BqHoR5R5mi4SuzU0GnVacAWtrN8sWalAPcsE"
                  clientKey:@"vpmvuy4VhPeTJlM6Dzhrr4P7Y0Gr3RJxLNHhBjJr"];
    
    
    
    //Initialize Parse Analytics
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    
    //Initialize FaceBookSDK
//    [PFFacebookUtils initializeFacebook];
//    [FBLoginView class];
   
    
    //Initialize MixPanel
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication
//                        withSession:[PFFacebookUtils session]];
//}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
