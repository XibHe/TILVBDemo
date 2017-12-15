//
//  LoginViewController.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "LiveMainViewController.h"
#import "TILVBRequestServer+RequestManager.h"

@interface LoginViewController ()
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorLightGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"登录";
    // 自动登录
    [self autoLogin];
    
    CGFloat tfHeight = 44;
    int index = 0;
    
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    _userNameTF.backgroundColor = [UIColor whiteColor];
    _userNameTF.layer.borderWidth = 0.5;
    _userNameTF.layer.borderColor = kColorGray.CGColor;
    _userNameTF.layer.cornerRadius = 5.0;
    _userNameTF.placeholder = @"用户名";
    _userNameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:_userNameTF];
    index++;
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultMargin, kDefaultMargin)];
    _passwordTF.backgroundColor = [UIColor whiteColor];
    _passwordTF.layer.borderWidth = 0.5;
    _passwordTF.layer.borderColor = kColorGray.CGColor;
    _passwordTF.layer.cornerRadius = 5.0;
    _passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTF.placeholder = @"密码";
    [self.view addSubview:_passwordTF];
    index++;
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kDefaultMargin*(index+2) + tfHeight*index, ScreenWidth-(kDefaultMargin*4), tfHeight)];
    loginBtn.backgroundColor = kColorRed;
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kAppMiddleTextFont;
    [loginBtn addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    index++;
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - kDefaultMargin - 100, kDefaultMargin*(index+2) + tfHeight*index, 100, tfHeight)];
    registBtn.layer.cornerRadius = 5.0;
    [registBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
    [registBtn setTitleColor:kColorBlack forState:UIControlStateNormal];
    registBtn.titleLabel.font = kAppMiddleTextFont;
    [registBtn addTarget:self action:@selector(onRegist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    index++;
}

// 自动登录
- (void)autoLogin
{
    NSDictionary *dic = [self getLocalLoginParam];
    if (dic)
    {
        NSString *identifier = [dic objectForKey:kLoginIdentifier];
        NSString *passward = [dic objectForKey:kLoginPassward];
        if (identifier.length > 0 && passward.length > 0)
        {
            [self login:identifier passward:passward];
        }
    }
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

- (void)onLogin:(UIButton *)button
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
    
    [self login:_userNameTF.text passward:_passwordTF.text];
}

- (void)login:(NSString *)identifier passward:(NSString *)pwd
{
    [SVProgressHUD showWithStatus:@"正在登录"];
    
    __weak typeof(self) ws = self;
//    //请求sig
//    LoginRequest *sigReq = [[LoginRequest alloc] initWithHandler:^(BaseRequest *request) {
//        LoginResponceData *responseData = (LoginResponceData *)request.response.data;
//        [AppDelegate sharedAppDelegate].token = responseData.token;
//        [[ILiveLoginManager getInstance] iLiveLogin:identifier sig:responseData.userSig succ:^{
//            [SVProgressHUD dismiss];
//            CLog(@"tillivesdkshow login succ");
//            [ws saveLoginParamToLocal:identifier passward:pwd];
//
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LiveMainViewController alloc] init]];
//            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
//
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            [SVProgressHUD dismiss];
//            if (errId == 8050)//离线被踢,再次登录
//            {
//                [ws login:identifier passward:pwd];
//            }
//            else
//            {
//                NSString *errInfo = [NSString stringWithFormat:@"module=%@,errid=%d,errmsg=%@",module,errId,errMsg];
//                NSLog(@"login fail.%@",errInfo);
//                [AlertHelp alertWith:@"登录失败" message:errInfo cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
//            }
//        }];
//    } failHandler:^(BaseRequest *request) {
//        [SVProgressHUD dismiss];
//        NSString *errInfo = [NSString stringWithFormat:@"errid=%ld,errmsg=%@",(long)request.response.errorCode, request.response.errorInfo];
//        NSLog(@"login fail.%@",errInfo);
//        [AlertHelp alertWith:@"登录失败" message:errInfo cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
//    }];
//    sigReq.identifier = identifier;
//    sigReq.pwd = pwd;
//    [[WebServiceEngine sharedEngine] asyncRequest:sigReq];
    
    NSDictionary *paramDic = @{
                               @"appid" : @([ShowAppId intValue]),
                               @"id"  : identifier,
                               @"pwd" : pwd,
                               @"appid" : @([[ILiveSDK getInstance] getAppId])
                               };
    
    [TILVBRequestServer iLiveLoginWithParams:paramDic success:^(id JSON) {
        CLog(@"iLiveLogin JSON = %@",JSON);
        
        [AppDelegate sharedAppDelegate].token = JSON[@"token"];
        
        [[ILiveLoginManager getInstance] iLiveLogin:identifier sig:JSON[@"userSig"] succ:^{
            [SVProgressHUD dismiss];
            CLog(@"tillivesdkshow login succ");
            [ws saveLoginParamToLocal:identifier passward:pwd];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LiveMainViewController alloc] init]];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
        } failed:^(NSString *module, int errId, NSString *errMsg) {
            [SVProgressHUD dismiss];
            if (errId == 8050)//离线被踢,再次登录
            {
                [ws login:identifier passward:pwd];
            }
            else
            {
                NSString *errInfo = [NSString stringWithFormat:@"module=%@,errid=%d,errmsg=%@",module,errId,errMsg];
                NSLog(@"login fail.%@",errInfo);
                [AlertHelp alertWith:@"登录失败" message:errInfo cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
            }
        }];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSString *errInfo = error.userInfo[@"errorInfo"];
        NSLog(@"login fail.%@",errInfo);
        [AlertHelp alertWith:@"登录失败" message:errInfo cancelBtn:@"确定" alertStyle:UIAlertControllerStyleAlert cancelAction:nil];
    }];
}

- (NSDictionary *)getLocalLoginParam
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:kLoginParam];
    return dic;
}

- (void)onRegist:(UIButton *)button
{
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)saveLoginParamToLocal:(NSString *)identifier passward:(NSString *)pwd
{
    NSMutableDictionary *loginParam = [NSMutableDictionary dictionary];
    [loginParam setObject:identifier forKey:kLoginIdentifier];
    [loginParam setObject:pwd forKey:kLoginPassward];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginParam forKey:kLoginParam];
}


@end
