//
//  StoreVC.h
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface StoreVC : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (nonatomic,strong) NSString *titleTextStr;
@property (strong, nonatomic) IBOutlet UILabel *peopleNumLab;
@property (strong, nonatomic) IBOutlet UILabel *singlePriceLab;
@property (strong, nonatomic) IBOutlet UILabel *tuihuoNumLab;
@property (strong, nonatomic) IBOutlet UILabel *tuihuoMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *yingMoneyLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) NSArray *masterArr;
@end
