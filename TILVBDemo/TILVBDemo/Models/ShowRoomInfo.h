//
//  ShowRoomInfo.h
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/12/14.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowRoomInfo : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, assign) NSInteger roomnum;
@property (nonatomic, copy) NSString * groupid;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * host;
@property (nonatomic, assign) NSInteger appid;
@property (nonatomic, assign) int thumbup;//点赞数
@property (nonatomic, assign) int memsize;//观看人数
@property (nonatomic, assign) NSInteger device;
@property (nonatomic, assign) NSInteger videotype;

@property (nonatomic, strong) NSString *roleName;

- (NSDictionary *)toRoomDic;

@end
