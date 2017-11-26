//
//  RegistViewController.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "RegistViewController.h"
#import "TILVBRequestServer+RequestManager.h"
@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";
    [self registerRequest];
}

- (void)registerRequest
{
    NSDictionary *params = @{@"id": @"a123456",
                             @"pwd": @"12345678"
                             };
    [TILVBRequestServer getRegistedWithParams:params success:^(id JSON) {
        CLog(@"");
    } failure:^(NSError *error) {
        CLog(@"");
    }];
}

@end
