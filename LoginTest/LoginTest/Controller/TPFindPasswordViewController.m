//
//  TPFindPasswordViewController.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/30.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPFindPasswordViewController.h"
#import "TPDataBaseHelper.h"
#import "TPUserinfo.h"

@interface TPFindPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersText;

@end

@implementation TPFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
}

- (IBAction)backgroundClicked:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)findButtonClicked:(UIButton *)sender {
    TPDataBaseHelper *helper = [TPDataBaseHelper sharedDatabaseHelper];
    NSString *users = self.usersText.text;
    TPUserinfo *user = [[TPUserinfo alloc]initWithUsers:users password:@""];
    NSArray *arr = [helper queryUserinfo];
    for (TPUserinfo *auser in arr) {
        if ([auser.users isEqualToString:user.users]) {
            user.password = auser.password;
            UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"找回成功" message:[NSString stringWithFormat:@"恭喜您，已经找回您的密码，您的密码为:%@,请妥善保管您的密码",user.password] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [aler addAction:action];
            [self presentViewController:aler animated:YES completion:nil];
            return;
        }
    }
    UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"找回失败" message:@"对不起，您的账号不存在" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [aler addAction:action];
    [self presentViewController:aler animated:YES completion:nil];
}

@end
