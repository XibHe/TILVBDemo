//
//  TILVBRequestServer.h
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(NSError* error);

@interface TILVBRequestServer : NSObject
/**
 *  这个是朗致http post请求方法
 *
 *  @param params  这个是业务层传得参数
 *  @param url 这个是是否业务参数在content字典里面(登录 ，注册，修改密码 业务参数在param里面 传NO)
 
 *  @param success 这个是请求成功后回调的block
 *  @param failure 这个是请求失败的回调block
 */
+ (void)postWithUrl:(NSString*)url params:(NSDictionary*)params  success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failue;
@end
