//
//  TPDataBaseHelper.h
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@class TPUserinfo;
 
@interface TPDataBaseHelper : NSObject

@property (nonatomic,strong)FMDatabase *db;



+(TPDataBaseHelper *)sharedDatabaseHelper;

-(void)insertUserinfo:(TPUserinfo *)userinfo;
-(void)updateUserinfo:(TPUserinfo *)userinfo newUserinfo:(TPUserinfo *)newUserinfo;
-(NSArray *)queryUserinfo;

@end
