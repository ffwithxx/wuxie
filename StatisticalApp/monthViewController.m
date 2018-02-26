//
//  monthViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/20.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "monthViewController.h"
#import "monthTableViewCell.h"
#import "BGControl.h"
#define kCellName @"monthTableViewCell"
@interface monthViewController () {
 monthTableViewCell *_cell;
}

@end

@implementation monthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self first];
}

- (void)first {
    self.titleText.text = self.titleTextStr;
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.masterArr.count;i++) {
        NSDictionary *dict = _masterArr[i];
        
        NSString *dateStr =  [BGControl dateToDateString:[dict valueForKey:@"samd051"]];
        BOOL isAdd = true;
        int indexNum = 0;
        NSDecimalNumber *money = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber *order = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDictionary *masterDict = [[NSMutableDictionary alloc] init];
        NSDictionary *masteDictOne = [[NSDictionary alloc] init];
        for (int j = 0; j < self.dataArray.count; j++) {
            
            if ([dateStr isEqualToString:[self.dataArray[j] valueForKey:@"date"]]) {
                isAdd = false;
                indexNum = j;
                masteDictOne =self.dataArray[j];
            }
        }
        if (isAdd) {
            money = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]];
          NSDecimalNumber   *order = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]];
            [masterDict setValue:dateStr forKey:@"date"];
            [masterDict setValue:money forKey:@"money"];
             [masterDict setValue:order forKey:@"order"];
            [self.dataArray addObject:masterDict];
            
        }else{
            NSDecimalNumber *moneyOne = [masteDictOne valueForKey:@"money"];
            NSDecimalNumber *orderOne = [masteDictOne valueForKey:@"order"];
            moneyOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]]];
              orderOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",orderOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]]];
            NSMutableDictionary *dictOne = [[NSMutableDictionary alloc] init];
            [dictOne setValue:moneyOne forKey:@"money"];
            [dictOne setValue:dateStr forKey:@"date"];
            [dictOne setValue:orderOne forKey:@"order"];
            [self.dataArray replaceObjectAtIndex:indexNum withObject:dictOne];
            
        }
        
        
    }
    [self.bigTabView reloadData];
}



- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[monthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
//    _cell.delegate = self;
    NSDictionary *dict = self.dataArray[indexPath.row];
        _cell.dateLabel.text= [dict valueForKey:@"date"];
        _cell.orderNumLab.text = [BGControl notRounding:[dict valueForKey:@"order"] afterPoint:2];
        _cell.SalesvolumeLab.text = [BGControl notRounding:[dict valueForKey:@"money"] afterPoint:2];
    
        
        
 
    return _cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
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
