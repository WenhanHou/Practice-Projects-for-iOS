//
//  ViewController.m
//  NotificationTest
//
//  Created by Wenhan on 3/24/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UITextField *notifTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.notifTF = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, 150, 60)];
    self.notifTF.backgroundColor = [UIColor lightGrayColor];
    self.notifTF.textColor = [UIColor blueColor];
    self.notifTF.text = @"Status";
    [self.view addSubview:_notifTF];
    
    
    self.locationManager = [[CLLocationManager alloc] init] ;
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter =kCLDistanceFilterNone;
    
    [self.locationManager requestAlwaysAuthorization];
    
    //CLLocationCoordinate2D location2D = {33.000188, -96.716192};
    CLLocationCoordinate2D location2D = {31.020123  , -96.747200};
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location2D radius:200 identifier:@"RegionID"];
    
    [self.locationManager startMonitoringForRegion:region];
    
  //  [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    notification.alertBody = @"Did Exit Region";
//    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    
    //
//    UILocalNotification *notif = [[UILocalNotification alloc] init];
//    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
//    notif.fireDate = fireDate;
//    NSTimeZone* tz = [NSTimeZone defaultTimeZone];
//    notif.timeZone = tz;
//    notif.alertBody = @"Did Exit Region";
//    notif.alertAction = @"Show";
//    notif.soundName = UILocalNotificationDefaultSoundName;
//    notif.applicationIconBadgeNumber = 2;
//    notif.repeatInterval = NSCalendarUnitSecond;
//    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
//    NSLog(@"%@" ,_locationManager.monitoredRegions);
//    
//    NSLog(@"%d" , [CLLocationManager regionMonitoringAvailable] );
}

//delegate methods
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
  //   UIApplication *app  = [UIApplication sharedApplication];
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = [NSDate date];
    NSTimeZone* tz = [NSTimeZone defaultTimeZone];
    notif.timeZone = tz;
    notif.alertBody = @"Did Exit Region";
    notif.alertAction = @"Show";
    notif.soundName = UILocalNotificationDefaultSoundName;
    
  // [app presentLocalNotificationNow:notif];
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
    self.notifTF.text = @"Already left this region";
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    
    //UIApplication *app  = [UIApplication sharedApplication];
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = [NSDate date];
    NSTimeZone* tz = [NSTimeZone defaultTimeZone];
    notif.timeZone = tz;
    notif.alertBody = @"Did enter Region";
    notif.alertAction = @"Show";
    notif.soundName = UILocalNotificationDefaultSoundName;
   // notif.region = region;
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
   //   [app presentLocalNotificationNow:notif];
   self.notifTF.text = @"Already entered this region";
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Region monitoring failed with error: %@", [error localizedDescription]);
}

//LocationManager代理方法 return current location
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    //[self.motionActivityManager stopActivityUpdates];
    //[self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Start", nil)];
    
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
 //   CLLocationAccuracy horizonAccuracy = location.horizontalAccuracy;
    
    NSLog(@"%@", location);
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
