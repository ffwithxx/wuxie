//
//  saleViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/20.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "saleViewController.h"
#import "saleTableViewCell.h"
#import "BGControl.h"
#define kCellName @"saleTableViewCell"
@interface saleViewController ()<UITableViewDelegate,UITableViewDataSource> {
    saleTableViewCell *_cell;
    NSMutableArray *titlesArr;
}


@end

@implementation saleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
[self first];
}

- (void)first {
    self.titleText.text = self.titleTextStr;
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
            
            [titlesArr addObject:masterDict];
        }else {
           
            NSDecimalNumber *moneyOne = [masteDictOne valueForKey:@"money"];
            moneyOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",moneyOne]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"samdA1damnt"]]]];
            NSMutableDictionary *dictOne = [[NSMutableDictionary alloc] init];
            [dictOne setValue:moneyOne forKey:@"money"];
             [dictOne setValue:name forKey:@"name"];
            [titlesArr replaceObjectAtIndex:indexNum withObject:dictOne];
            
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
  [self.bigTableView reloadData];
    
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
        _cell = [[saleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    _cell.delegate = self;
    _cell.nameLab.text= [titlesArr[indexPath.row] valueForKey:@"name"] ;
 _cell.SalesvolumeLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:[titlesArr[indexPath.row] valueForKey:@"money"] afterPoint:2]];
    
    
    
    
    return _cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titlesArr.count;
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
