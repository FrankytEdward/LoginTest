//
//  TPDataBaseHelper.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPDataBaseHelper.h"
#import "TPUserinfo.h"

static TPDataBaseHelper *helper = nil;


@implementation TPDataBaseHelper

+(TPDataBaseHelper *)sharedDatabaseHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TPDataBaseHelper alloc]init];
        [helper createDataBase];
        [helper createTable];
    });
    return helper;
}
//创建数据库
-(void)createDataBase
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filPath = [doc stringByAppendingPathComponent:@"userinfo.sqlite"];
    NSLog(@"%@",filPath);
    self.db = [FMDatabase databaseWithPath:filPath];
}

//创建表
-(void)createTable
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_userinfo (id integer PRIMARY KEY AUTOINCREMENT, users text NOT NULL, password text NOT NULL);"];
        if (result) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"创建失败");
        }
        [self.db close];
    }else{
        NSLog(@"数据库打开失败");
    }
}

//插入操作
-(void)insertUserinfo:(TPUserinfo *)userinfo
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_userinfo (users, password) VALUES (?,?);",userinfo.users,userinfo.password];
        if (result) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
        [self.db close];
    }else{
        NSLog(@"打开数据库失败");
    }
}

//修改数据
-(void)updateUserinfo:(TPUserinfo *)userinfo newUserinfo:(TPUserinfo *)newUserinfo
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"UPDATE t_userinfo SET users = ?,password = ? WHERE password = ?",
                       userinfo.users,newUserinfo.password,userinfo.password];
        if (result) {
            NSLog(@"修改成功");
        }else{
            NSLog(@"修改失败");
        }
        [self.db close];
    }else{
        NSLog(@"数据库打开失败");
    }
}

//查询
-(NSArray *)queryUserinfo
{
    NSMutableArray *arr = [NSMutableArray array];
    if ([self.db open]) {
        FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_userinfo"];
        while ([set next]) {
            NSString *users = [set stringForColumn:@"users"];
            NSString *password = [set stringForColumn:@"password"];
            TPUserinfo *userinfo = [[TPUserinfo alloc]initWithUsers:users password:password];
            [arr addObject:userinfo];
        }
    }
    return arr;
}

@end
