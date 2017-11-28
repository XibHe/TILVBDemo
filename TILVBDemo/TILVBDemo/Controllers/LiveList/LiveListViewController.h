//
//  LiveListViewController.h
//  TILVBDemo
//
//  直播列表
//
//  Created by zyjk_iMac-penghe on 2017/11/28.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveListViewController : UIViewController
{
    RequestPageParamItem    *_pageItem;
    NSMutableArray          *_datas;
}

// 加载更多
- (void)loadMore:(TCIVoidBlock)complete;

@end
