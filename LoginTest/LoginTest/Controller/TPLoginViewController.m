//
//  TPLoginViewController.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPLoginViewController.h"
#import "TPRegisterViewController.h"
#import "TPUserinfo.h"
#import "TPDataBaseHelper.h"
#import "TPPassedViewController.h"
#import "TPFindPasswordViewController.h"
#import "TPChangePasswordViewController.h"

@interface TPLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UISwitch *isRemenberPassword;

@end

@implementation TPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userText.text = [defaults objectForKey:@"users"];
    self.passWordText.text = [defaults objectForKey:@"password"];
    self.isRemenberPassword.on = [[defaults objectForKey:@"isRemenberPassword"] boolValue];
}

- (IBAction)backgroundClicked:(id)sender {
    [self.view endEditing:YES];
}



- (IBAction)loginClicked:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *users = self.userText.text;
    NSString *password = self.passWordText.text;
    TPUserinfo *user = [[TPUserinfo alloc]initWithUsers:users password:password];
    TPDataBaseHelper *helper = [TPDataBaseHelper sharedDatabaseHelper];
    NSArray *arr = [helper queryUserinfo];
    for (TPUserinfo *aUser in arr) {
        if ([aUser.users isEqualToString:user.users] && [aUser.password isEqualToString:user.password]) {
            
            NSNumber *isRemenberPassword = [NSNumber numberWithBool:self.isRemenberPassword.on];
            [defaults setObject:users forKey:@"users"];
            [defaults setObject:isRemenberPassword forKey:@"isRemenberPassword"];
            if (self.isRemenberPassword.on) {
                [defaults setObject:password forKey:@"password"];
            }else{
                [defaults setObject:@"" forKey:@"password"];
            }
            
            TPPassedViewController *passedViewController = [[TPPassedViewController alloc]init];
            //[self.navigationController pushViewController:passedViewController animated:YES];
            [self presentViewController:passedViewController animated:YES completion:nil];
            return;
        }else if ([aUser.users isEqualToString:user.users] && ![aUser.password isEqualToString:user.password]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"对不起，您的密码输入错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [defaults setObject:@"" forKey:@"password"];
            self.passWordText.text = @"";
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"对不起，您输入的账号不存在" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)findPassword:(UIButton *)sender {
    TPFindPasswordViewController *findcontroller = [[TPFindPasswordViewController alloc]init];
    [self.navigationController pushViewController:findcontroller animated:YES];
}

- (IBAction)registerClicked:(UIButton *)sender {
    TPRegisterViewController *registerController = [[TPRegisterViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registerController animated:YES];
    
}

- (IBAction)changePassword:(UIButton *)sender {
    TPChangePasswordViewController *cvc = [[TPChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

@end
