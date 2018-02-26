//
//  BestSellVC.m
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BestSellVC.h"
#import "BestSellCell.h"
#import "BGControl.h"
#define kCellName @"BestSellCell"
@interface BestSellVC (){
    BestSellCell *_cell;
}

@end

@implementation BestSellVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self first];
}
- (void)first {
    self.titleText.text = @"畅销上商品排行";
    self.dataArray = [[NSMutableArray alloc] init];
      NSDecimalNumber *jiaoyiMoney = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i < _masterArr.count; i++) {
        NSDictionary *dict = _masterArr[i];
        NSDecimalNumber *danjia = [dict valueForKey:@"samdA1damnt"];
        jiaoyiMoney = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",danjia]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]]];
    }
    for (int i = 0; i<self.masterArr.count;i++) {
         NSDictionary *dict = _masterArr[i];
           NSString *nameStr =  [dict valueForKey:@"samd002Name"];
        if ([BGControl isNULLOfString:nameStr]) {
            nameStr = @"其他";
        }
          BOOL isAdd = true;
          int indexNum = 0;
        NSDecimalNumber *money = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber *order = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber *bili = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDictionary *masterDict = [[NSMutableDictionary alloc] init];
        NSDictionary *masteDictOne = [[NSDictionary alloc] init];
        for (int j = 0; j < self.dataArray.count; j++) {
            
            if ([nameStr isEqualToString:[self.dataArray[j] valueForKey:@"name"]]) {
                isAdd = false;
                indexNum = j;
                masteDictOne =self.dataArray[j];
            }
            
        }
        if (isAdd) {
            money = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]];
            NSDecimalNumber   *order = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]];
            
            NSDecimalNumber *biliOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",money]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]]];
            NSDecimalNumber *biliTwo = [biliOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
            [masterDict setValue:nameStr forKey:@"name"];
            [masterDict setValue:money forKey:@"money"];
            [masterDict setValue:order forKey:@"order"];
            [masterDict setValue:[BGControl notRounding:biliTwo afterPoint:2] forKey:@"bili"];
            [self.dataArray addObject:masterDict];
            
        }else{
            NSDecimalNumber *moneyOne = [masteDictOne valueForKey:@"money"];
            NSDecimalNumber *orderOne = [masteDictOne valueForKey:@"order"];
            
            moneyOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]]];
            orderOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",orderOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]]];
            NSDecimalNumber *biliOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",jiaoyiMoney]]];
            NSDecimalNumber *biliTwo = [biliOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
            NSMutableDictionary *dictOne = [[NSMutableDictionary alloc] init];
            [dictOne setValue:moneyOne forKey:@"money"];
            [dictOne setValue:nameStr forKey:@"name"];
            [dictOne setValue:orderOne forKey:@"order"];
            [dictOne setValue:[BGControl notRounding:biliTwo afterPoint:2] forKey:@"bili"];
            [self.dataArray replaceObjectAtIndex:indexNum withObject:dictOne];
            
        }
    }
  
    [self arraySortDESC];
}
#pragma mark -- 数组排序方法（降序）

- (void)arraySortDESC{
    
    //数组排序
    //对数组进行排序
    
    NSArray *result = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
        
        return [[obj2 valueForKey:@"money"] compare:[obj1 valueForKey:@"money"]]; //降序
        
    }];
    self.dataArray = [[NSMutableArray alloc] initWithArray:result];
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
        _cell = [[BestSellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    _cell.delegate = self;
    NSDictionary *dict = self.dataArray[indexPath.row];
    _cell.dateLabel.text= [dict valueForKey:@"name"];
    _cell.buyNum.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:[dict valueForKey:@"money"] afterPoint:2]];
    _cell.keNum.text =[NSString stringWithFormat:@"%@",[BGControl notRounding:[dict valueForKey:@"order"] afterPoint:2]];;
    _cell.moneyLabel.text =[NSString stringWithFormat:@"%@%@",[dict valueForKey:@"bili"],@"%"];
    
    
    
    return _cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
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
