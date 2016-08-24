//
//  ActivityManager.h
//  CMMotionActivityMonitor
//
//  Created by Wenhan on 2/12/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface ActivityManager : NSObject

@property (strong, nonatomic) CMMotionActivity *activity;

@end
