//
//  ViewController.m
//  CMMotionActivityMonitor
//
//  Created by Wenhan on 2/12/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;

@property (nonatomic, strong) CMMotionActivityManager *motionActivityManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Start", nil)
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(startUpdateActivity)];
}


- (void)startUpdateActivity {
    if ([CMMotionActivityManager isActivityAvailable]) {
        //avoid iteration
        __weak typeof(self) weakSelf = self;
        [self.motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity * _Nullable activity) {
//            weakSelf.statusLabel.text = [activity description];
//            
//            if (activity.stationary) {
//                weakSelf.statusLabel.text = [NSString stringWithFormat:@"The user's status is %@",@"stationary"];
//            } else if (activity.walking) {
//                weakSelf.statusLabel.text = [NSString stringWithFormat:@"The user's status is %@",@"walking"];
//            } else if (activity.automotive) {
//                weakSelf.statusLabel.text = [NSString stringWithFormat:@"The user's status is %@",@"automotive"];
//            } else if (activity.running) {
//                weakSelf.statusLabel.text = [NSString stringWithFormat:@"The user's status is %@",@"running"];
//            } else {
//                weakSelf.statusLabel.text = @"Unknown";
//            }
        }];
        
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Stop", nil)];
        [self.navigationItem.rightBarButtonItem setAction:@selector(stopUpdateActivity)];
    }
    
}


- (void)stopUpdateActivity
{
    [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Start", nil)];
    [self.navigationItem.rightBarButtonItem setAction:@selector(startUpdateActivity)];
    
    //stop activity updates
    [self.motionActivityManager stopActivityUpdates];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
