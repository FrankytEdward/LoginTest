//
//  TPChangePasswordViewController.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/30.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPChangePasswordViewController.h"
#import "TPDataBaseHelper.h"
#import "TPUserinfo.h"

@interface TPChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersText;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *nowPassword;

@property (weak, nonatomic) IBOutlet UITextField *affirmPassword;


@end

@implementation TPChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
}

- (IBAction)backgroundClicked:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)changePassword:(UIButton *)sender {
    NSString *users = self.usersText.text;
    NSString *oldPassword = self.oldPassword.text;
    NSString *nowPassword = self.nowPassword.text;
    NSString *affirmPassword = self.affirmPassword.text;
    TPUserinfo *oldUser = [[TPUserinfo alloc]initWithUsers:users password:oldPassword];
    TPDataBaseHelper *helper = [TPDataBaseHelper sharedDatabaseHelper];
    NSArray *arr = [helper queryUserinfo];
    for (TPUserinfo *aUser in arr) {
        if ([aUser.users isEqualToString:oldUser.users]) {
            if ([aUser.password isEqualToString:oldUser.password]) {
                if ([nowPassword isEqualToString:affirmPassword]) {
                    TPUserinfo *nowUser = [[TPUserinfo alloc]initWithUsers:users password:nowPassword];
                    [helper updateUserinfo:oldUser newUserinfo:nowUser];
                    UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"修改成功" message:@"恭喜您，您已经成功修改您的密码，请妥善保管您的密码" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [aler addAction:action];
                    [self presentViewController:aler animated:YES completion:nil];
                    return;
                }else{
                    UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"修改失败" message:@"对不起，两次输入的密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                    [aler addAction:action];
                    [self presentViewController:aler animated:YES completion:nil];
                    return;
                }
            }else{
                UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"修改失败" message:@"对不起，您的旧密码输入错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [aler addAction:action];
                [self presentViewController:aler animated:YES completion:nil];
                return;
            }
            
        }
        
    }
    UIAlertController *aler = [UIAlertController  alertControllerWithTitle:@"修改失败" message:@"对不起，您的账号不存在" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [aler addAction:action];
    [self presentViewController:aler animated:YES completion:nil];
}

@end
