//
//  LiveMainViewController.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/27.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "LiveMainViewController.h"

@interface LiveMainViewController ()

@end

@implementation LiveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播列表";
    UISegmentedControl *segmentedCtl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 30.0f) ];
    [segmentedCtl insertSegmentWithTitle:@"最新直播" atIndex:0 animated:YES];
    [segmentedCtl insertSegmentWithTitle:@"录制回放" atIndex:1 animated:YES];
    segmentedCtl.multipleTouchEnabled = NO;
    segmentedCtl.selectedSegmentIndex = 0;
    [segmentedCtl addTarget:self action:@selector(onSegmeted:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedCtl];
    
    // 直播列表页
    _liveListVC = [[LiveListViewController alloc] init];
    [_liveListVC.view setFrame:self.view.bounds];
    _liveListVC.view.hidden = NO;
    [_liveListVC loadMore:nil];
    [self addChildViewController:_liveListVC];
    [self.view addSubview:_liveListVC.view];
    
    // 回放列表页
    _recordListVC = [[RecordListViewController alloc] init];
    [_recordListVC.view setFrame:self.view.bounds];
    _recordListVC.view.hidden = YES;
    [self addChildViewController:_recordListVC];
    [self.view addSubview:_recordListVC.view];
}

- (void)onSegmeted:(UISegmentedControl *)segmented
{
    if (segmented.selectedSegmentIndex == 0)
    {
        _liveListVC.view.hidden = NO;
        _recordListVC.view.hidden = YES;
    } else {
        _liveListVC.view.hidden = YES;
        _recordListVC.view.hidden = NO;
    }
}

@end
