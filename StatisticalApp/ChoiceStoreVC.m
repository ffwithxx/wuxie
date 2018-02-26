//
//  ChoiceStoreVC.m
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ChoiceStoreVC.h"
#import "ChoiceStoreCell.h"
#import "AFClient.h"
#define kcellName @"ChoiceStoreCell"
#import "SuperStudent.pch"
@interface ChoiceStoreVC ()<UITableViewDelegate,UITableViewDataSource> {
    
    ChoiceStoreCell *_cell;
    NSMutableArray *postArr;
}

@end

@implementation ChoiceStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    postArr = [NSMutableArray new];
    self.dataArray = [NSMutableArray array];
     [self first];
    // Do any additional setup after loading the view.
}
- (IBAction)goback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)first {
    [self show];
    [[AFClient shareInstance] GetAvailableStoreswithArr:postArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
          if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
              NSArray *arr = [responseBody valueForKey:@"data"];
              if (arr.count > 0) {
                    self.dataArray = [NSMutableArray arrayWithArray:arr];
              }
            
          }else {
            
              [self Alert:@"请求失败"];
              
          }
        [self.bigTableView reloadData];
        [self dismiss];
    } failure:^(NSError *error) {
         [self dismiss];
    }];
    
}

- (void)Alert:(NSString *)AlertStr{
    [LYMessageToast toastWithText:AlertStr backgroundColor:kBlackColor font:[UIFont systemFontOfSize:15] fontColor:kWhiteColor duration:2.f inView:self.view];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kcellName];
    if (!_cell) {
        _cell = [[ChoiceStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellName];
    }
    NSDictionary *dict = self.dataArray[indexPath.row];
    _cell.nameLab.text = [dict valueForKey:@"dept002"];
    return _cell;
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     NSDictionary *dict = self.dataArray[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(fanStoreStr:withIdStr:)]) {
        [_delegate fanStoreStr:[dict valueForKey:@"dept002"] withIdStr:[dict valueForKey:@"dept001"]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
