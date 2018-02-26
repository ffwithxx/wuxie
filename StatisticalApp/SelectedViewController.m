//
//  SelectedViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "SelectedViewController.h"
#import "CustomDatePicker.h"
#import "payTypeViewController.h"
#import "saleViewController.h"
#import "monthViewController.h"
#import "BestSellVC.h"
#import "saleViewController.h"
#import "StoreVC.h"
#import "ChoiceStoreVC.h"
#import "ChoiceStoreVC.h"
#import "AFClient.h"
#import "BGControl.h"
#import "SuperStudent.pch"

@interface SelectedViewController ()<CustomDatePickerDelegate,fanDelegate> {
    
    CustomDatePicker *customPicker;
    UIButton *_button;
    NSString *tagNum;
    NSString *storeidStr;
    NSUInteger bthTag;
    NSMutableArray *postArr;
}
@end

@implementation SelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    postArr = [[NSMutableArray alloc] init];
    [self first];
    // Do any additional setup after loading the view.
}
- (void)first {
    tagNum = @"";
     NSDate *date0 = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *string = [format stringFromDate:date0];
    self.beginTimeText.text = string;
    self.endTimeText.text = string;
    self.titleText.text = self.titleTextStr;
    customPicker = [[CustomDatePicker alloc] init];
    customPicker.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    customPicker.delegate = self;

    [self.view addSubview:customPicker];
    [customPicker SetDatePickerMode:UIDatePickerModeTime withDateFormatterStr:@"yyyy-MM-dd"];

}

- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];


}
- (IBAction)buttonclick:(UIButton *)sender {
    if (sender.tag == 202 || sender.tag == 203) {
        if ([tagNum isEqualToString:@""] ) {
            customPicker.hiddenCustomPicker = NO;
            tagNum = [NSString stringWithFormat:@"%ld",sender.tag];
        }else {
            customPicker.hiddenCustomPicker = YES;
        }

    }else if (sender.tag == 204) {
             customPicker.hiddenCustomPicker = YES;
        if (![BGControl isNULLOfString:self.storetextFile.text] ) {
            [self getData];
        }else {
            
            [self Alert:@"请选择门店！"];
        }
        
        
        
       
        
    }else if (sender.tag == 201){
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChoiceStoreVC *choiceVC = [storyboard instantiateViewControllerWithIdentifier:@"ChoiceStoreVC"];
        choiceVC.delegate = self;
        [self.navigationController pushViewController:choiceVC animated:YES];
        
    }
   //    sender.selected = !sender.selected;
    

}
- (void)getData {
    [self show];
    [[AFClient shareInstance] GetStoreCashDatawithstoreId:storeidStr withstartDate:self.beginTimeText.text withendDate:self.endTimeText.text withArr:postArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
           if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
               NSArray *arr = [responseBody valueForKey:@"data"];
//               if (arr.count < 1) {
//                   [self Alert:@"无数据！"];
//               }else{
                   //付款方式
                   payTypeViewController *paytypeVc = [storyboard instantiateViewControllerWithIdentifier:@"payTypeViewController"];
                   paytypeVc.titleTextStr = self.titleTextStr;
                   //        [self.navigationController pushViewController:paytypeVc animated:YES];
                   monthViewController *monthVc = [storyboard instantiateViewControllerWithIdentifier:@"monthViewController"];
                   monthVc.titleTextStr = self.titleTextStr;
                   BestSellVC *bestVC = [storyboard instantiateViewControllerWithIdentifier:@"BestSellVC"];
                   saleViewController *saleVC = [storyboard instantiateViewControllerWithIdentifier:@"saleViewController"];
                   saleVC.titleTextStr = self.titleTextStr;
                   StoreVC *storeVC = [storyboard instantiateViewControllerWithIdentifier:@"StoreVC"];
                   storeVC.titleTextStr = self.titleTextStr;
                   if ([self.titleTextStr isEqualToString:@"畅销商品排行"]) {
                       bestVC.masterArr = [responseBody valueForKey:@"data"];
                       [self.navigationController pushViewController:bestVC animated:YES];
                   }else if ([self.titleTextStr isEqualToString:@"大类销售分布"]){
                       saleVC.masterArr = [responseBody valueForKey:@"data"];
                       [self.navigationController pushViewController:saleVC animated:YES];
                   }else if ([self.titleTextStr isEqualToString:@"类别销售统计"]){
                       paytypeVc.masterArr = [responseBody valueForKey:@"data"];
                       [self.navigationController pushViewController:paytypeVc animated:YES];
                   }else if ([self.titleTextStr isEqualToString:@"门店营业概况"]){
                       storeVC.masterArr = [responseBody valueForKey:@"data"];
                       [self.navigationController pushViewController:storeVC animated:YES];
                   }
                   else{
                       monthVc.masterArr = [responseBody valueForKey:@"data"];
                       [self.navigationController pushViewController:monthVc animated:YES];
                   }
                   
//               }
        
           }else {
               NSString *str = [responseBody valueForKey:@"errors"];
               [self Alert:str];
               
               
           }
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}
#pragma mark -- CustomDatePicker delegate
- (void)returnDateStrWithDateStr:(NSString *)dateStr {

    if ([tagNum isEqualToString:@"202"]) {
        self.beginTimeText.text = dateStr;
    }else {
      self.endTimeText.text = dateStr;
    }
    tagNum =@"";
    NSLog(@"%@", dateStr);
}

- (void)alreadyHiddtnDatePicker {
    
    _button.selected = NO;
     tagNum =@"";
    NSLog(@"视图隐藏");
}
-(void)fanStoreStr:(NSString *)storeStr withIdStr:(NSString *)idStr {
    self.storetextFile.text = storeStr;
    storeidStr = idStr;
    
}

- (void)Alert:(NSString *)AlertStr{
    [LYMessageToast toastWithText:AlertStr backgroundColor:kBlackColor font:[UIFont systemFontOfSize:15] fontColor:kWhiteColor duration:2.f inView:self.view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
