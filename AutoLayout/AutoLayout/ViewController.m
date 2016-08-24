//
//  ViewController.m
//  AutoLayout
//
//  Created by 侯文翰 on 14-11-27.
//  Copyright (c) 2014年 侯文翰. All rights reserved.
//

#import "ViewController.h"
#import "DetailVC.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)handleButtonJump:(UIButton *)sender {
    DetailVC *detailVC = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    [self presentViewController:detailVC animated:YES completion:^{
        NSLog(@"completion");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
