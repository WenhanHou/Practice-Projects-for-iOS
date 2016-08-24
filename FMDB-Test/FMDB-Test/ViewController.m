//
//  ViewController.m
//  FMDB-Test
//
//  Created by Wenhan on 2/4/16.
//  Copyright (c) 2016 Wenhan. All rights reserved.
//

#import "ViewController.h"

#import <FMDatabase.h>
#import <sqlite3.h>
#import "UserHistory.h"
#import "DBManager.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *path = [docsPath stringByAppendingPathComponent:@"database.sqlite"];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [self showBtn];
    
    
}


- (void) showBtn{
    UIButton *insertBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    insertBtn.backgroundColor = [UIColor lightGrayColor];
    [insertBtn addTarget:self action:@selector(addInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insertBtn];
    
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 30)];
    selectBtn.backgroundColor = [UIColor yellowColor];
    [selectBtn addTarget:self action:@selector(selectInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];

}

- (void)addInfo:(id)sender{
    UserHistory *user = [[UserHistory alloc] init];
    user.userId = @"001";
    user.lat = @"123123";
    user.log = @"42313123";
    user.descrition = @"this is a desc of an user";
    [DBManager createTable];
    [DBManager saveOrUpdataMessage:user];
}

- (void)selectInfo:(id)sender{
    UserHistory *user = [DBManager selectMessageByMessageId:@"001"];
    NSLog(@"%@, %@, %@, %@",user.userId, user.lat, user.log, user.descrition);
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
