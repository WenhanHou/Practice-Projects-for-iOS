//
//  AppDelegate.m
//  backGroundTest
//
//  Created by Wenhan on 3/17/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (assign, nonatomic) UIBackgroundTaskIdentifier bgTask;

@property (strong, nonatomic) dispatch_block_t expirationHandler;
@property (assign, nonatomic) BOOL jobExpired;
@property (assign, nonatomic) BOOL background;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIApplication* app = [UIApplication sharedApplication];
    
    __weak NSUAAAIOSAppDelegate* selfRef = self;
    
    self.expirationHandler = ^{  //创建后台自唤醒，当180s时间结束的时候系统会调用这里面的方法
        [app endBackgroundTask:selfRef.bgTask];
        selfRef.bgTask = UIBackgroundTaskInvalid;
        selfRef.bgTask = [app beginBackgroundTaskWithExpirationHandler:selfRef.expirationHandler];
        NSLog(@"Expired");
        selfRef.jobExpired = YES;
        while(selfRef.jobExpired)
        {
            // spin while we wait for the task to actually end.
            NSLog(@"等待180s循环进程的结束");
            [NSThread sleepForTimeInterval:1];
        }
        // Restart the background task so we can run forever.
        [selfRef startBackgroundTask];
    };
    
    // Assume that we're in background at first since we get no notification from device that we're in background when
    // app launches immediately into background (i.e. when powering on the device or when the app is killed and restarted)
    [self monitorBatteryStateInBackground];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //[locationManager startUpdatingLocation];
    return YES;
}

- (void)monitorBatteryStateInBackground
{
    self.background = YES;
    [self startBackgroundTask];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"App is active");
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;//取消应用程序通知脚标
    [locationManager stopUpdatingLocation];
    self.background = NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //if([self bgTask])
    if(isLogined)//当登陆状态才启动后台操作
    {
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:self.expirationHandler];
        NSLog(@"Entered background");
        [self monitorBatteryStateInBackground];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error//当定位服务不可用出错时，系统会自动调用该函数
{
    NSLog(@"定位服务出错");
    if([error code]==kCLErrorDenied)//通过error的code来判断错误类型
    {
        //Access denied by user
        NSLog(@"定位服务未打开");
        [InterfaceFuncation ShowAlertWithMessage:@"错误" AlertMessage:@"未开启定位服务\n客户端保持后台功能需要调用系统的位置服务\n请到设置中打开位置服务" ButtonTitle:@"好"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations//当用户位置改变时，系统会自动调用，这里必须写一点儿代码，否则后台时间刷新不管用
{
    NSLog(@"位置改变，必须做点儿事情才能刷新后台时间");
    CLLocation *loc = [locations lastObject];
    //NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    //NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
    // Lat/Lon
    float latitudeMe = loc.coordinate.latitude;
    float longitudeMe = loc.coordinate.longitude;
}

- (void)startBackgroundTask
{
    NSLog(@"Restarting task");
    if(isLogined)//当登陆状态才进入后台循环
    {
        // Start the long-running task.
        NSLog(@"登录状态后台进程开启");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // When the job expires it still keeps running since we never exited it. Thus have the expiration handler
            // set a flag that the job expired and use that to exit the while loop and end the task.
            NSInteger count=0;
            BOOL NoticeNoBackground=false;//只通知一次标志位
            BOOL FlushBackgroundTime=false;//只通知一次标志位
            locationManager.distanceFilter = kCLDistanceFilterNone;//任何运动均接受，任何运动将会触发定位更新
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;//定位精度
            while(self.background && !self.jobExpired)
            {
                NSLog(@"进入后台进程循环");
                [NSThread sleepForTimeInterval:1];
                count++;
                if(count>60)//每60s进行一次开启定位，刷新后台时间
                {
                    count=0;
                    [locationManager startUpdatingLocation];
                    NSLog(@"开始位置服务");
                    [NSThread sleepForTimeInterval:1];
                    [locationManager stopUpdatingLocation];
                    NSLog(@"停止位置服务");
                    FlushBackgroundTime=false;
                }
                if(!isLogined)//未登录或者掉线状态下关闭后台
                {
                    NSLog(@"保持在线进程失效，退出后台进程");
                    [InterfaceFuncation ShowLocalNotification:@"保持在线失效，登录已被注销，请重新登录"];
                    [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
                    return;//退出循环
                }
                NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
                NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
                if(backgroundTimeRemaining<30&&NoticeNoBackground==false)
                {
                    [InterfaceFuncation ShowLocalNotification:@"向系统申请长时间保持后台失败，请结束客户端重新登录"];
                    NoticeNoBackground=true;
                }
                //测试后台时间刷新
                if(backgroundTimeRemaining>200&&FlushBackgroundTime==false)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageUpdate" object:@"刷新后台时间成功\n"];
                    FlushBackgroundTime=true;
                    //[InterfaceFuncation ShowLocalNotification:@"刷新后台时间成功"];
                }
            }
            self.jobExpired = NO;
        });
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "wenhan.backGroundTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"backGroundTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"backGroundTest.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
