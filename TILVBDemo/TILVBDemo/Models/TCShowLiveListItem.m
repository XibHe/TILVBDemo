//
//  TCShowLiveListItem.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/12/14.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "TCShowLiveListItem.h"
#import "NSMutableDictionary+Json.h"
#import "NSObject+Json.h"

@implementation TCShowLiveListItem
- (void)saveToLocal
{
    NSMutableDictionary *tcShowUserDic = [NSMutableDictionary dictionary];
    [tcShowUserDic setObject:self.uid ? self.uid : @"" forKey:@"uid"];

    NSMutableDictionary *listItemDic = [NSMutableDictionary dictionary];
    [listItemDic setObject:tcShowUserDic forKey:@"host"];
    [listItemDic setObject:self.info.title ? self.info.title : @"" forKey:@"title"];
    [listItemDic setObject:self.info.cover ? self.info.cover : @"" forKey:@"cover"];
    [listItemDic setObject:self.info.groupid ? self.info.groupid : @"" forKey:@"groupid"];
    [listItemDic setObject:[NSNumber numberWithInteger:self.info.roomnum] forKey:@"roomnum"];
    [listItemDic setObject:self.info.roleName ? self.info.roleName : kSxbRole_HostHD forKey:@"roleName"];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    NSString *useridKey = [NSString stringWithFormat:@"LiveListItem_%@", [[ILiveLoginManager getInstance] getLoginId]];

    [ud setObject:listItemDic forKey:useridKey];
}

- (void)cleanLocalData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    NSString *useridKey = [NSString stringWithFormat:@"LiveListItem_%@", [[ILiveLoginManager getInstance] getLoginId]];

    [ud setObject:nil forKey:useridKey];
}

+ (instancetype)loadFromToLocal
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *useridKey = [NSString stringWithFormat:@"LiveListItem_%@", [[ILiveLoginManager getInstance] getLoginId]];
    if (useridKey)
    {
        NSDictionary *listItemDic = [ud dictionaryForKey:useridKey];
        if (!listItemDic)
        {
            return nil;
        }
        NSLog(@"%@", listItemDic);
        NSMutableDictionary *tcShowUserDic = [listItemDic objectForKey:@"host"];

        TCShowLiveListItem *item = [[TCShowLiveListItem alloc] init];
        item.info = [[ShowRoomInfo alloc] init];

        item.uid = [tcShowUserDic objectForKey:@"uid"];

        item.info.title = [listItemDic objectForKey:@"title"];
        item.info.cover = [listItemDic objectForKey:@"cover"];
        item.info.groupid = [listItemDic objectForKey:@"groupid"];
        item.info.roomnum = [[listItemDic objectForKey:@"roomnum"] intValue];
        item.info.roleName = [listItemDic objectForKey:@"roleName"];

        //加载之后置空
        [ud setObject:nil forKey:useridKey];

        return item;
    }
    else
    {
        return nil;
    }
    return nil;
}

- (NSString *)liveIMChatRoomId
{
    return self.info.groupid;
}

- (void)setLiveIMChatRoomId:(NSString *)liveIMChatRoomId
{
    self.info.groupid = liveIMChatRoomId;
}

// 直播房间Id
- (int)liveAVRoomId
{
    return (int)self.info.roomnum;
}

// 直播标题
- (NSString *)liveTitle
{
    return self.info.title;
}

- (NSString *)liveCover
{
    return self.info.cover;
}


- (NSDictionary *)toLiveStartJson
{
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    [json addString:self.info.title forKey:@"title"];
    [json addInteger:self.info.roomnum forKey:@"roomnum"];
    [json addString:self.info.type forKey:@"live"];
    [json addString:self.info.groupid forKey:@"groupid"];
    [json addString:self.info.cover forKey:@"cover"];

    NSMutableDictionary *host = [[NSMutableDictionary alloc] init];

    [host addString:self.uid forKey:@"uid"];
    [json setObject:host forKey:@"host"];

    return json;
}

- (NSDictionary *)toHeartBeatJson
{
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    [json addString:self.uid forKey:@"uid"];
    return json;
}


@end
