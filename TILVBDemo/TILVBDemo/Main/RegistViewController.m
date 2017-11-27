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
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kColorLightGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"注册";
    
    CGFloat tfHeight = 44;
    int index = 0;
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    _userNameTF.backgroundColor = kColorWhite;
    _userNameTF.layer.borderWidth = 0.5;
    _userNameTF.layer.borderColor = kColorGray.CGColor;
    _userNameTF.layer.cornerRadius = 5.0;
    _userNameTF.placeholder = @"用户名4～24个字符,不能为纯数字";
    [self.view addSubview:_userNameTF];
    index++;
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.backgroundColor = kColorWhite;
    _passwordTF.layer.borderWidth = 0.5;
    _passwordTF.layer.borderColor = kColorGray.CGColor;
    _passwordTF.layer.cornerRadius = 5.0;
    _passwordTF.placeholder = @"用户密码为8-16个字符";
    [self.view addSubview:_passwordTF];
    index++;
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    registBtn.backgroundColor = kColorRed;
    registBtn.layer.cornerRadius = 5.0;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    registBtn.titleLabel.font = kAppMiddleTextFont;
    [registBtn addTarget:self action:@selector(onRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    index++;
}

//用户名为4～24个字符，不能为纯数字
- (BOOL)invalidAccount:(NSString *)account
{
    if (account.length < 4 || account.length > 24)
    {
        return YES;
    }
    
    NSString *inputString = [account stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (inputString.length <= 0) {//是纯数字
        return YES;
    }
    else{
        return NO;
    }
}

//密码长度为8～16个字符
- (BOOL)invalidPwd:(NSString *)pwd
{
    if (pwd.length < 8 || pwd.length > 16)
    {
        return YES;
    }
    return NO;
}

- (void)onRegist:(UIButton *)button
{
    if (!_userNameTF || _userNameTF.text.length < 1)
    {
        [AlertHelp alertWith:nil message:@"请输入用户名" cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
        return;
    }
    if (!_passwordTF || _passwordTF.text.length < 1)
    {
        [AlertHelp alertWith:nil message:@"请输入密码" cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
        return;
    }
    
    if ([self invalidAccount:_userNameTF.text])
    {
        [AlertHelp alertWith:nil message:@"输入用户名格式不对" cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
        return;
    }
    if ([self invalidPwd:_passwordTF.text])
    {
        [AlertHelp alertWith:nil message:@"输入密码格式不对" cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在注册"];
    
    __weak typeof(self) ws = self;
    //向业务后台注册
    RegistRequest *registReq = [[RegistRequest alloc] initWithHandler:^(BaseRequest *request) {
        [SVProgressHUD dismiss];
        AlertActionHandle okBlock = ^(UIAlertAction * _Nonnull action){
            [ws.navigationController popViewControllerAnimated:YES];
            [ws.delegate showRegistUserIdentifier:ws.userNameTF.text];
            [ws.delegate showRegistUserPwd:ws.passwordTF.text];
        };
        [AlertHelp alertWith:@"注册成功" message:nil funBtns:@{@"确定":okBlock} cancelBtn:nil alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
    } failHandler:^(BaseRequest *request) {
        [SVProgressHUD dismiss];
        NSString *errinfo = [NSString stringWithFormat:@"errid=%ld,errmsg=%@",(long)request.response.errorCode,request.response.errorInfo];
        CLog(@"regist fail.%@",errinfo);
        [AlertHelp alertWith:@"注册失败" message:errinfo cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
    }];
    registReq.identifier = _userNameTF.text;
    registReq.pwd = _passwordTF.text;
    [[WebServiceEngine sharedEngine] asyncRequest:registReq];

}

@end
