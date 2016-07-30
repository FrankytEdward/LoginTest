//
//  TPRegisterViewController.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPRegisterViewController.h"
#import "TPDataBaseHelper.h"
#import "TPUserinfo.h"


@interface TPRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation TPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
}

- (IBAction)backClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backgroundClicked:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)registerClicked:(UIButton *)sender {
    TPDataBaseHelper *helper = [TPDataBaseHelper sharedDatabaseHelper];
    if (self.userText.text && self.passwordText.text && ![self.userText.text isEqualToString:@""] && ![self.passwordText.text isEqual: @""]) {
        NSString *users = self.userText.text;
        for (TPUserinfo *user in [helper queryUserinfo]) {
            if (user.users == users) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"对不起，您要注册的账号已经存在" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        }
        NSString *password = self.passwordText.text;
            
        TPUserinfo *userinfo = [[TPUserinfo alloc]initWithUsers:users password:password];
        [helper insertUserinfo:userinfo];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功！" message:@"恭喜您，您的账号已经成功注册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end
