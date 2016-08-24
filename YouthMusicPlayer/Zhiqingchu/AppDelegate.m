//
//  AppDelegate.m
//  Zhiqingchu
//
//  Created by lanouhn on 14-10-27.
//  Copyright (c) 2014年 Smile. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UMSocial.h"
//#import "ViewController.h"
@implementation AppDelegate
- (void)dealloc{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainVC;
    [mainVC release];
    

    
//     [UMSocialData setAppKey:@"507fcab25270157b37000010"];
//    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//    }
//    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
//        ViewController *appStartController = [[ViewController alloc] init];
//        self.window.rootViewController = appStartController;
//        [appStartController release];
//    }else {
//        
//        MainTabBarController *mainVC = [[MainTabBarController alloc] init];
//        self.window.rootViewController = mainVC;
//        [mainVC release];
//    }
    
//    UIImageView *appImage = [[[UIImageView alloc]initWithFrame:self.window.bounds]autorelease];
//    appImage.image = [UIImage imageNamed:@"first.jpg"];
//    [self.window addSubview:appImage];
//    [UIView animateWithDuration:3.0 animations:^{
//        CATransform3D tranform = CATransform3DMakeScale(1.5, 1.5, 1.0);
//        appImage.layer.transform = tranform;
//        appImage.alpha = 1;
//        
//    } completion:^(BOOL finished) {
//        [appImage removeFromSuperview];
//        
//    }];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
