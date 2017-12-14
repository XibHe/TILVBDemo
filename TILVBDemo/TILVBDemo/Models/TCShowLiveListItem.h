//
//  TCShowLiveListItem.h
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/12/14.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRoomInfo.h"

@interface TCShowLiveListItem : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) ShowRoomInfo *info;

//@property (nonatomic, strong) HostLBS *lbs;

+ (instancetype)loadFromToLocal;

- (void)saveToLocal;
- (void)cleanLocalData;

- (NSDictionary *)toLiveStartJson;
- (NSDictionary *)toHeartBeatJson;
@end
