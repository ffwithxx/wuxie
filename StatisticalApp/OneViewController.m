//
//  OneViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OneViewController.h"
#import "SuperStudent.pch"
#import "SelectedViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oneView.frame = CGRectMake(0, 60, kScreenSize.width, self.oneView.frame.size.height);
       self.twoView.frame = CGRectMake(0, 60+ self.oneView.frame.size.height, kScreenSize.width, self.oneView.frame.size.height);
     self.threeView.frame = CGRectMake(0, 60+ self.oneView.frame.size.height*2, kScreenSize.width, self.oneView.frame.size.height);
    
     self.fiveView.frame = CGRectMake(0, 60+ self.oneView.frame.size.height*3, kScreenSize.width, self.oneView.frame.size.height);
     self.sexView.frame = CGRectMake(0, 60+ self.oneView.frame.size.height*4, kScreenSize.width, self.oneView.frame.size.height);
    // Do any additional setup after loading the view.
}
- (IBAction)goNextPage:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectedViewController *selectedVc = [storyboard instantiateViewControllerWithIdentifier:@"SelectedViewController"];
    if (sender.tag == 201) {
        selectedVc.titleTextStr = @"门店营业概况";
    }else if (sender.tag == 202) {
    selectedVc.titleTextStr = @"类别销售统计";
    }else if (sender.tag == 203) {
        selectedVc.titleTextStr = @"月度营业走势";
    }else if (sender.tag == 204) {
        selectedVc.titleTextStr = @"付款方式分布";
    }else if (sender.tag == 205) {
        selectedVc.titleTextStr = @"大类销售分布";
    }else if (sender.tag == 206) {
        selectedVc.titleTextStr = @"畅销商品排行";
    }
     selectedVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectedVc animated:YES];
    
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
