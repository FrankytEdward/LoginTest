//
//  TPUserinfo.h
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUserinfo : NSObject

@property (nonatomic,strong)NSString *users;
@property (nonatomic,strong)NSString *password;
-(instancetype)initWithUsers:(NSString *)users password:(NSString *)password;

@end
