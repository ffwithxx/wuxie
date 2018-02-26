//
//  payTypeViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "payTypeViewController.h"
#import "payTypeTableViewCell.h"
#import "BGControl.h"
#define kcellName @"payTypeTableViewCell"
@interface payTypeViewController ()<UITableViewDelegate,UITableViewDataSource> {

    payTypeTableViewCell *_cell;
    NSMutableArray *titlesArr;
}

@end

@implementation payTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self first];
}
- (void)first {
    self.titleText.text = self.titleTextStr;
    self.bigTableView.backgroundColor = [UIColor whiteColor];
    self.dataArray = [[NSMutableArray alloc] init];
    
    titlesArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _masterArr.count; i++) {
        NSDictionary *dict = _masterArr[i];
        int samdMainTypeKind = [[dict valueForKey:@"samdMainTypeKind"] intValue];
        NSString *name;
        NSDecimalNumber *money = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDictionary *masterDict = [[NSMutableDictionary alloc] init];
        //判断samdMainTypeKind数值来选择大分类
        if (samdMainTypeKind == 1) {
            name = [dict valueForKey:@"samd002TypeName1"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
            
        }else if (samdMainTypeKind == 2){
            name = [dict valueForKey:@"samd002TypeName2"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }else if (samdMainTypeKind == 3){
            name = [dict valueForKey:@"samd002TypeName3"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }else if (samdMainTypeKind == 4){
            name = [dict valueForKey:@"samd002TypeName4"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }
        BOOL isAdd = true;
        int indexNum = 0;
        //判断是否已经存在这个大分类
        NSDictionary *masteDictOne = [[NSDictionary alloc] init];
        for (int j = 0; j < titlesArr.count; j++) {
            
            if ([name isEqualToString:[titlesArr[j] valueForKey:@"name"]]) {
                isAdd = false;
                indexNum = j;
                masteDictOne =titlesArr[j];
            }
        }
        //算钱
        
        if (isAdd) {
            money = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]];
            [masterDict setValue:name forKey:@"name"];
            [masterDict setValue:money forKey:@"money"];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [masterDict setValue:arr forKey:@"smallArr"];
            [titlesArr addObject:masterDict];
        }else {
            
            NSDecimalNumber *moneyOne = [masteDictOne valueForKey:@"money"];
            moneyOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]]];
            NSMutableDictionary *dictOne = [[NSMutableDictionary alloc] init];
            [dictOne setValue:moneyOne forKey:@"money"];
            [dictOne setValue:name forKey:@"name"];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [masterDict setValue:arr forKey:@"smallArr"];
            [titlesArr replaceObjectAtIndex:indexNum withObject:dictOne];
            
        }
    }
    [self setData];
}
- (void)setData{
    for (int i = 0; i < _masterArr.count; i++) {
        NSDictionary *dict = _masterArr[i];
        NSString *name ;
        int samdMainTypeKind = [[dict valueForKey:@"samdMainTypeKind"] intValue];
        if (samdMainTypeKind == 1) {
            name = [dict valueForKey:@"samd002TypeName1"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
            
        }else if (samdMainTypeKind == 2){
            name = [dict valueForKey:@"samd002TypeName2"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }else if (samdMainTypeKind == 3){
            name = [dict valueForKey:@"samd002TypeName3"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }else if (samdMainTypeKind == 4){
            name = [dict valueForKey:@"samd002TypeName4"];
            if ([BGControl isNULLOfString:name]) {
                name = @"其他";
            }
        }
         NSDictionary *smallDictOne = [[NSDictionary alloc] init];
        for (int j = 0; j < titlesArr.count; j++) {
            NSDictionary *dictOne = titlesArr[j];
            if ([[dictOne valueForKey:@"name"] isEqualToString:name]) {
               
                 NSArray *arrTwo = [dictOne valueForKey:@"smallArr"];
                
                NSString *nameStr = [dict valueForKey:@"samd002Name"];
                if ([BGControl isNULLOfString:nameStr]) {
                    nameStr = @"其他";
                }
                BOOL isAddOne = true;
                int indexNumOne = 0;
                for (int m = 0; m<arrTwo.count; m++) {
                    NSString *orderName = [arrTwo[m] valueForKey:@"name"];
                    if ([orderName isEqualToString:nameStr]) {
                        isAddOne = false;
                        indexNumOne = m;
                         smallDictOne =arrTwo[m];
                        
                    }
                    
                }
                NSMutableDictionary *smallDict = [[NSMutableDictionary alloc] init];
               
                if (isAddOne) {
                   NSDecimalNumber *money = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]];
                     NSDecimalNumber *order = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]];
                    [smallDict setValue:nameStr forKey:@"name"];
                    [smallDict setValue:money forKey:@"money"];
                    [smallDict setValue:order forKey:@"order"];
                    [smallDict setValue:name forKey:@"bigName"];
                    NSMutableArray *arr = [NSMutableArray arrayWithArray:arrTwo];
                    
                    [arr insertObject:smallDict atIndex:0];
                    
                    NSMutableDictionary *dictdata = [[NSMutableDictionary alloc] init];
                    [dictdata setValue:[dictOne valueForKey:@"name"] forKey:@"name"];
                    [dictdata setValue:[dictOne valueForKey:@"money"] forKey:@"money"];
                    [dictdata setValue:arr forKey:@"smallArr"];
                    [titlesArr replaceObjectAtIndex:j withObject:dictdata];
                }else{
                    NSDecimalNumber *moneyOne = [smallDictOne valueForKey:@"money"];
                    NSDecimalNumber *orderOne = [smallDictOne valueForKey:@"order"];
                    moneyOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]]];
                    orderOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",orderOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA01iqty"]]]];
                    NSMutableDictionary *dictthree = [[NSMutableDictionary alloc] init];
                    [dictthree setValue:moneyOne forKey:@"money"];
                    [dictthree setValue:nameStr forKey:@"name"];
                    [dictthree setValue:orderOne forKey:@"order"];
                    [dictthree setValue:name forKey:@"bigName"];
                     NSMutableArray *arr = [NSMutableArray arrayWithArray:arrTwo];
                    [arr replaceObjectAtIndex:indexNumOne withObject:dictthree];
                    
                    NSMutableDictionary *dictdata = [[NSMutableDictionary alloc] init];
                    [dictdata setValue:[dictOne valueForKey:@"name"] forKey:@"name"];
                    [dictdata setValue:[dictOne valueForKey:@"money"] forKey:@"money"];
                    [dictdata setValue:arr forKey:@"smallArr"];
                    [titlesArr replaceObjectAtIndex:j withObject:dictdata];
                    
                }
                
            }
        }
    }
    [self arraySortDESC];
}

#pragma mark -- 数组排序方法（降序）

- (void)arraySortDESC{
    
    //数组排序
    //对数组进行排序
    
    NSArray *result = [titlesArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
        
        return [[obj2 valueForKey:@"money"] compare:[obj1 valueForKey:@"money"]]; //降序
        
    }];
    titlesArr = [[NSMutableArray alloc] initWithArray:result];
    [self arraySortDESCTwo];
    
}
- (void)arraySortDESCTwo{
    
    //数组排序
    //对数组进行排序
    
    for (int i = 0; i < titlesArr.count; i++) {
        NSDictionary *dict = titlesArr[i];
        NSArray *arr = [dict valueForKey:@"smallArr"];
        NSArray *result = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
            
            return [[obj2 valueForKey:@"money"] compare:[obj1 valueForKey:@"money"]]; //降序
            
        }];
        NSMutableDictionary *masterDict = [[NSMutableDictionary alloc] init];
        [masterDict setValue:[dict valueForKey:@"name"] forKey:@"name"];
        [masterDict setValue:[dict valueForKey:@"money"] forKey:@"money"];
        [masterDict setValue:result forKey:@"smallArr"];
        [titlesArr replaceObjectAtIndex:i withObject:masterDict];
    }
   
    [self.bigTableView reloadData];
    
}

- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kcellName];
    if (!_cell) {
        _cell = [[payTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellName];
    }
   
    NSDictionary *dict = titlesArr[indexPath.row] ;
    [_cell showDict:dict];
    
    return _cell;
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titlesArr.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = titlesArr[indexPath.row] ;
    NSArray *arr = [dict valueForKey:@"smallArr"];
    
    return arr.count * 40;

    
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
