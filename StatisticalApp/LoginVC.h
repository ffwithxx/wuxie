//
//  LoginVC.h
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *parentStore;
@property (strong, nonatomic) IBOutlet UITextField *sonStore;
@property (strong, nonatomic) IBOutlet UITextField *pwdText;
@property (strong, nonatomic) IBOutlet UIImageView *pwdImg;

@end
