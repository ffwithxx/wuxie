//
//  AFClient.h
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHttpHeader @"http://106.14.238.250/nbw/"
#define KHeader @"2DD8F2D2-4C62-4593-B745-AE4254BCBE4C"
@interface AFClient : NSObject

typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlcok)(NSError *error);

@property (nonatomic,strong)ProgressBlock progressBolck;
@property (nonatomic,strong)SuccessBlock successBlock;
@property (nonatomic,strong)FailureBlcok failureBlock;


+(instancetype)shareInstance;

- (void)LoginByuserId:(NSString *)userId  withPassword:(NSString *)password  withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)GetAvailableStoreswithArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)GetStoreCashDatawithstoreId:(NSString *)storeId withstartDate:(NSString *)startDate withendDate:(NSString *)endDate   withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

@end
