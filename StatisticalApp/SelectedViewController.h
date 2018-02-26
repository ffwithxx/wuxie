//
//  SelectedViewController.h
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectedViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong,nonatomic) NSString *titleTextStr;
@property (strong, nonatomic) IBOutlet UITextField *storetextFile;

@property (strong, nonatomic) IBOutlet UITextField *beginTimeText;
@property (strong, nonatomic) IBOutlet UITextField *endTimeText;
@property (nonatomic,retain) UIDatePicker *datePicker;
@end
