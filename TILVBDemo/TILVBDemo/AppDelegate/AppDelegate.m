//
//  AppDelegate.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()<QAVLogger>

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setUpSVProgress];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    self.window.rootViewController = nav;
    
    
    TIMManager *manager = [[ILiveSDK getInstance] getTIMManager];
    
    NSNumber *evn = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvParam];
    [manager setEnv:[evn intValue]];
    
    NSNumber *logLevel = [[NSUserDefaults standardUserDefaults] objectForKey:kLogLevel];
    if (!logLevel)//默认debug等级
    {
        [[NSUserDefaults standardUserDefaults] setObject:@(TIM_LOG_DEBUG) forKey:kLogLevel];
        logLevel = @(TIM_LOG_DEBUG);
    }
    [self disableLogPrint];//禁用日志控制台打印
    [manager setLogLevel:(TIMLogLevel)[logLevel integerValue]];
    
    // 初始化SDK
    [[ILiveSDK getInstance] initSdk:[ShowAppId intValue] accountType:[ShowAccountType intValue]];
    
    NSString *ver = [[ILiveSDK getInstance] getVersion];
    CLog(@"ILiveSDK Version is %@", ver);
    
    return YES;
}

#pragma mark 控制等待提示样式
-(void)setUpSVProgress
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}

- (void)disableLogPrint
{
    TIMManager *manager = [[ILiveSDK getInstance] getTIMManager];
    [manager initLogSettings:NO logPath:[manager getLogPath]];
    [[ILiveSDK getInstance] setConsoleLogPrint:NO];
    [QAVAppChannelMgr setExternalLogger:self];
}

#pragma mark - avsdk日志代理
- (BOOL)isLogPrint
{
    return NO;
}

- (NSString *)getLogPath
{
    return [[TIMManager sharedInstance] getLogPath];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
