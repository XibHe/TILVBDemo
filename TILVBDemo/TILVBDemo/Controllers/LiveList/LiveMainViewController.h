//
//  LiveMainViewController.h
//  TILVBDemo
//
//  最新直播 + 录制回放 （SegmentedControl）
//
//  Created by zyjk_iMac-penghe on 2017/11/27.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListViewController.h"
#import "RecordListViewController.h"

@interface LiveMainViewController : UIViewController
@property (nonatomic, strong) LiveListViewController    *liveListVC;
@property (nonatomic, strong) RecordListViewController  *recordListVC;
@end
