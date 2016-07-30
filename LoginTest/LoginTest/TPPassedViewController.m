//
//  TPPassedViewController.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/30.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPPassedViewController.h"
#import "TPLoginViewController.h"
@interface TPPassedViewController ()

@end

@implementation TPPassedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)quitClicked:(UIButton *)sender {
    TPLoginViewController *loginController = [[TPLoginViewController alloc]init];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:loginController];
    [self presentViewController:nv animated:YES completion:nil];
}


@end
