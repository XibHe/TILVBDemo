//
//  ShowRoomInfo.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/12/14.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "ShowRoomInfo.h"
#import "NSMutableDictionary+Json.h"
#import "NSObject+Json.h"

@implementation ShowRoomInfo

- (NSDictionary *)toRoomDic
{
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    [json addString:_title forKey:@"title"];
    [json addString:_type forKey:@"type"];
    [json addInteger:_roomnum forKey:@"roomnum"];
    [json addString:_groupid forKey:@"groupid"];
    [json addString:_cover forKey:@"cover"];
    [json addString:_host forKey:@"host"];
    [json addInteger:_appid forKey:@"appid"];
    [json addInteger:_device forKey:@"device"];
    [json addInteger:_videotype forKey:@"videotype"];
    return json;
}

@end
