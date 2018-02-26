//
//  ChoiceStoreVC.h
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol fanDelegate <NSObject>

@optional

-(void)fanStoreStr:(NSString *)storeStr withIdStr:(NSString *)idStr  ;
@end


@interface ChoiceStoreVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) id<fanDelegate>delegate;
@end
