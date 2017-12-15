//
//  TILVBRequestServer+RequestManager.h
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "TILVBRequestServer.h"

@interface TILVBRequestServer (RequestManager)

/**
 注册接口
 */
+ (void)getRegistedWithParams:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 登录
 */
+ (void)iLiveLoginWithParams:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 获取直播列表
 */
+ (void)roomListWithParams:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

@end
