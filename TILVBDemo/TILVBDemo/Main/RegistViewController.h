//
//  RegistViewController.h
//  TILVBDemo
//
//  注册
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistViewControllerDelegate <NSObject>
- (void)showRegistUserIdentifier:(NSString *)identifier;
- (void)showRegistUserPwd:(NSString *)passward;
@end

@interface RegistViewController : UIViewController
@property (nonatomic, weak) id<RegistViewControllerDelegate> delegate;
@end
