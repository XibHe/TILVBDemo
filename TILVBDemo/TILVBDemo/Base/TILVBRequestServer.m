//
//  TILVBRequestServer.m
//  TILVBDemo
//
//  Created by zyjk_iMac-penghe on 2017/11/24.
//  Copyright © 2017年 zyjk_iMac-penghe. All rights reserved.
//

#import "TILVBRequestServer.h"

@implementation TILVBRequestServer

+ (void)postWithUrl:(NSString*)url params:(NSDictionary*)params  success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.validatesDomainName = NO;
//    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    manager.requestSerializer.timeoutInterval = 20.f; //设置请求超时时间
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    

    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *bodyObjDic = [responseObject objectForKey:@"data"];
        CLog(@"bodyObjDic = %@",bodyObjDic);
        //NSString *code = [bodyObjDic objectForKey:@"code"];
        NSInteger  code = [responseObject[@"errorCode"] integerValue];
        CLog(@"url = %@,code = %ld",url,code);
        if (code == 0) {
            if(success)
                success ([responseObject objectForKey:@"data"]);
        } else {
            NSError *error = [NSError errorWithDomain:@"请求错误" code:-1 userInfo:nil];
            if(failure)
                failure(error);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([@"NSURLErrorDomain" isEqualToString:error.domain]){
            error = [NSError errorWithDomain:@"请监测您的网络环境" code:error.code  userInfo:nil];
        }
        if([@"NSCocoaErrorDomain" isEqualToString:error.domain]){
            error = [NSError errorWithDomain:@"服务器繁忙，请稍候重试" code:error.code userInfo:nil];
        }
        if(failure)
            failure(error);
    }];
    
//    NSError *requestError = nil;
//    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:url parameters:params error:&requestError];
//    request.HTTPBody = [NSData data];
//    [manager.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        CLog(@"data = %@,response = %@",data,response);
//    }];
}

@end
