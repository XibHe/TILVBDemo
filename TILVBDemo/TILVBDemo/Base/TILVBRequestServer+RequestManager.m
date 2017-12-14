//
//  TILVBRequestServer+RequestManager.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "TILVBRequestServer+RequestManager.h"

@implementation TILVBRequestServer (RequestManager)

+(void)getRegistedWithParams:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self postWithUrl:[NSString stringWithFormat:@"%@",kILVBHost] params:params success:^(id JSON) {
        if(success){
            success(JSON);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

+ (void)roomListWithParams:(NSDictionary*)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    //[NSString stringWithFormat:@"%@svc=live&cmd=roomlist",host];
    [self postWithUrl:[NSString stringWithFormat:@"%@svc=live&cmd=roomlist",kILVBHost] params:params success:^(id JSON) {
        if(success){
            success(JSON);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}
@end
