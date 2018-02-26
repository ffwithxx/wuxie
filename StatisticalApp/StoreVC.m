//
//  StoreVC.m
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StoreVC.h"
#import "StoreCell.h"
#import "BGControl.h"
#define kcellName @"StoreCell"
@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    StoreCell *_cell;
}

@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self first];// Do any additional setup after loading the view.
}

- (void)first {
    self.titleText.text = self.titleTextStr;
    NSDecimalNumber *jiaoyiMoney = [NSDecimalNumber decimalNumberWithString:@"0"];
     NSDecimalNumber *tuihuoMoney = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSDecimalNumber *tuihuoNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSDecimalNumber *sumPeople = [NSDecimalNumber decimalNumberWithString:@"0"];
    if (_masterArr.count > 0) {
        for (int i = 0; i < _masterArr.count; i++) {
            NSDictionary *dict = _masterArr[i];
            NSDecimalNumber *danjia = [dict valueForKey:@"samdA1damnt"];
            jiaoyiMoney = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",danjia]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]]];
            NSDecimalNumber *tuihuoSingle =  [dict valueForKey:@"samdA2damnt"];
            tuihuoMoney = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tuihuoSingle]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tuihuoMoney]]];
            NSDecimalNumber *tuihuoNumSingle = [dict valueForKey:@"samdA02iqty"] ;
            tuihuoNum =[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tuihuoNum]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tuihuoNumSingle]]];
            NSDecimalNumber *singlePeople = [dict valueForKey:@"samdA01iqty"] ;
            sumPeople =[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",singlePeople]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",sumPeople]]];
        }
        self.yingMoneyLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:jiaoyiMoney afterPoint:2]];
        self.peopleNumLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:sumPeople afterPoint:2]];
        self.tuihuoMoneyLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:tuihuoMoney afterPoint:2]];
        self.tuihuoNumLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:tuihuoNum afterPoint:2]];
        NSDecimalNumber *yingyeSum = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tuihuoMoney]] ];
        self.sumPriceLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:yingyeSum afterPoint:2]];
        
        NSDecimalNumber *singlrPrice =  [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",sumPeople]] ];
        self.singlePriceLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:singlrPrice afterPoint:2]];
    }
   
  
    
}



- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果点击的是右边的tableView，不做任何处理
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
