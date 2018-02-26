 //
//  AFClient.m
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import "AFClient.h"
#import "BGControl.h"
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <AVFoundation/AVFoundation.h>
@interface AFClient ()
{
    NSString *_url;
    NSDictionary *_dict;
    NSString *idStr;
    NSURL  *_filePathURL;
    NSString * _fileName;
    NSProgress *_progressone;
   
  
}
@end

@implementation AFClient


+(instancetype)shareInstance{
    static AFClient *defineAFClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defineAFClient = [[AFClient alloc] init];
    });
    return defineAFClient;
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

- (AFHTTPSessionManager *)creatManager{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];

//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
    mgr.requestSerializer.timeoutInterval = 10;
    securityPolicy.allowInvalidCertificates = YES;
    [mgr.requestSerializer setValue:KHeader forHTTPHeaderField:@"apptoken"];
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    
    mgr.securityPolicy  = securityPolicy;
    mgr.requestSerializer=[AFHTTPRequestSerializer serializer];
    mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return mgr;
}

- (void)getUserInfoByUserId:(NSString *)Id progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@/v1/user/get",kHttpHeader];
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [[NSDictionary alloc] initWithObjectsAndKeys:Id,@"id", nil];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)LoginByuserId:(NSString *)userId  withPassword:(NSString *)password  withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kHttpHeader,@"WebApi/ErpUser/Create"];
    NSLog(@"%@",_url);
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId",password,@"password", nil];
    
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    [manager.requestSerializer  setValue:@"application/json"  forHTTPHeaderField:@"Content－Type"];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
     
        if (success) {
            success(dict);
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            
            NSLog(@"%@",dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
- (void)GetAvailableStoreswithArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    
    _url = [NSString stringWithFormat:@"%@/%@",kHttpHeader,@"WebApi/ErpUser/GetAvailableStores"];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
   manager.requestSerializer.timeoutInterval = 20.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager GET:_url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)GetStoreCashDatawithstoreId:(NSString *)storeId withstartDate:(NSString *)startDate withendDate:(NSString *)endDate   withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kHttpHeader,@"WebApi/ErpUser/GetStoreCashData"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSLog(@"%@",_url);
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:storeId,@"storeId",startDate,@"startDate",endDate,@"endDate", nil];
    
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
  
    [manager.requestSerializer setTimeoutInterval:15];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    [manager.requestSerializer  setValue:@"application/json"  forHTTPHeaderField:@"Content－Type"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager GET:_url parameters:_dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"111");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
@end
