//
//  TPUserinfo.m
//  LoginTest
//
//  Created by 蓝山工作室 on 16/7/29.
//  Copyright © 2016年 蓝山工作室. All rights reserved.
//

#import "TPUserinfo.h"

@implementation TPUserinfo

-(instancetype)initWithUsers:(NSString *)users password:(NSString *)password
{
    self = [super init];
    if (self) {
        self.users = users;
        self.password = password;
    }
    return self;
}

@end
