//
//  MainTabBarController.m
//  Zhiqingchu
//
//  Created by lanouhn on 14-10-27.
//  Copyright (c) 2014年 Smile. All rights reserved.
//

#import "MainTabBarController.h"
#import "TodayTableViewController.h"
#import "TingRadioViewController.h"
#import "TingChannelTableController.h"
#import "TingSelectViewController.h"
#import "ReadClassifyCollectionView.h"
#import "ReadCorpusCollectionView.h"
#import "ReadSelectViewController.h"
#import "FindViewController.h"
#import "MeTableViewController.h"
#import "TabBarViewController.h"
#import "TingBaseViewController.h"
#import "ReadBaseViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

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

    TodayTableViewController *today = [[[TodayTableViewController alloc] init] autorelease];
    UINavigationController *todayNav = [[[UINavigationController alloc] initWithRootViewController:today] autorelease];

    [UINavigationBar appearance].barTintColor = [UIColor darkGrayColor];
    
//    TingRadioViewController *tingRadio = [[[TingRadioViewController alloc] init] autorelease];
//    TingChannelTableController *tingChannel = [[[TingChannelTableController alloc] init] autorelease];
//    TingSelectViewController *tingSeclect = [[[TingSelectViewController alloc] init] autorelease];
//
//
//    tingRadio.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"TingControlBoardcast"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"TingControlBoardcast_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    tingChannel.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"TingControlChannel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"TingControlChannel_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tingChannel.tabBarItem release];
//    [tingRadio.tabBarItem release];
//    
//    tingSeclect.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"TingControlFeature"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"TingControlFeature_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [tingSeclect.tabBarItem release];
//    [tingSeclect.tabBarItem release];
 
//    TabBarViewController *tingBar = [[[TabBarViewController alloc] init] autorelease];
//    tingBar.viewControllers = @[tingRadio, tingChannel, tingSeclect];


//    tingBar.navigationItem.title = @"Ting";
    
    TingBaseViewController *tingVC = [[TingBaseViewController alloc] init];                      //1
    UINavigationController *tingNav = [[[UINavigationController alloc] initWithRootViewController:tingVC] autorelease];
    tingNav.navigationBar.barTintColor = [UIColor darkGrayColor];

    



//    ReadCorpusCollectionView *readCorpus = [[[ReadCorpusCollectionView alloc] init] autorelease];
//    
//    ReadClassifyCollectionView *readClassify = [[[ReadClassifyCollectionView alloc] init] autorelease];
//
//
//    ReadSelectViewController *readSelect = [[[ReadSelectViewController alloc] init] autorelease];
//    readSelect.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"ReadingFeatureButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ReadingFeatureButton_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    readCorpus.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"ReadingSeriesButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ReadingSeriesButton_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    readClassify.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"ReadingClassButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"ReadingClassButton_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//    [readSelect.tabBarItem release];
//    [readCorpus.tabBarItem release];
//    [readClassify.tabBarItem release];
//    TabBarViewController *readTaBar = [[[TabBarViewController alloc] init] autorelease];
//    readTaBar.navigationItem.title = @"阅读";
//    readTaBar.viewControllers = @[readSelect, readCorpus, readClassify];

    ReadBaseViewController *readVC = [[ReadBaseViewController alloc] init];                       //2
    UINavigationController *readNavi = [[[UINavigationController alloc] initWithRootViewController:readVC] autorelease];
    readNavi.navigationBar.tintColor = [UIColor darkGrayColor];
    FindViewController *find = [[[FindViewController alloc] init] autorelease];
    find.navigationItem.title = @"发现";
    UINavigationController *findNavi = [[[UINavigationController alloc] initWithRootViewController:find] autorelease];
    findNavi.navigationBar.tintColor = [UIColor darkGrayColor];
    MeTableViewController *me = [[[MeTableViewController alloc] init] autorelease];
    me.navigationItem.title = @"我";
    UINavigationController *meNavi = [[[UINavigationController alloc] initWithRootViewController:me] autorelease];
    meNavi.navigationBar.tintColor = [UIColor darkGrayColor];
    
    readNavi.navigationBar.barTintColor = [UIColor darkGrayColor];
    findNavi.navigationBar.barTintColor = [UIColor darkGrayColor];
    todayNav.navigationBar.barTintColor = [UIColor darkGrayColor];
    findNavi.navigationBar.barTintColor = [UIColor darkGrayColor];
    tingNav.navigationBar.barTintColor = [UIColor darkGrayColor];
    meNavi.navigationBar.barTintColor = [UIColor darkGrayColor];
//    UILabel *tingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    tingLabel.textColor = [UIColor whiteColor];
//    tingLabel.text = @"Ting";
//    tingLabel.textAlignment = NSTextAlignmentCenter;
//    tingNav.navigationItem.titleView = tingLabel;
//    [tingLabel release];
    
//    UILabel *readLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    readLabel.textColor = [UIColor whiteColor];
//    readLabel.text = @"阅读";
//    readLabel.textAlignment = NSTextAlignmentCenter;
//    tingNav.navigationItem.titleView = readLabel;
//    [readLabel release];
//    UILabel *findLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    findLabel.textAlignment = NSTextAlignmentCenter;
//    findLabel.text = @"发现";
//    findLabel.textColor = [UIColor whiteColor];
//    find.navigationItem.titleView = findLabel;
//    [findLabel release];
//    UILabel *meLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    meLabel.text = @"我";
//    meLabel.textAlignment = NSTextAlignmentCenter;
//    meLabel.textColor = [UIColor whiteColor];
//    me.navigationItem.titleView = meLabel;
//    [meLabel release];


    
    todayNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Today" image:[[UIImage imageNamed:@"todayTabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"todayTabbar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tingNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Ting" image:[[UIImage imageNamed:@"tingTabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tingTabbar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    readNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读" image:[[UIImage imageNamed:@"readTabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"readTabbar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    findNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"discoverTabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"discoverTabbar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    findNavi.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    meNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"userTabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"userTabbar_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    todayNav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -7);
    tingNav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -7);
    readNavi.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -7);
    findNavi.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -7);
    meNavi.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -7);
    [todayNav.tabBarItem release];
    [tingNav.tabBarItem release];
    [readNavi.tabBarItem release];
    [findNavi.tabBarItem release];
    [meNavi.tabBarItem release];

    self.viewControllers =@[todayNav, tingNav, readNavi, findNavi, meNavi];
    self.tabBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, 320, 50);

    [UINavigationBar appearance].barTintColor = [UIColor blackColor];

    
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    textLabel.textColor = [UIColor whiteColor];
//    textLabel.textAlignment = NSTextAlignmentCenter;
//    textLabel.text = @"Today";
//    today.navigationItem.titleView = textLabel;
//    [textLabel release];
    


    
    
    
    

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

@end
