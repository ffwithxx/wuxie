//
//  payTypeViewController.h
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface payTypeViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (nonatomic,strong) NSString *titleTextStr;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) NSArray *masterArr;
@end
