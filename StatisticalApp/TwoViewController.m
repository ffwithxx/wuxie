//
//  TwoViewController.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)first {
  self.oldPwdText.secureTextEntry = YES;
    self.onePwdText.secureTextEntry = YES;
    self.twoPwdText.secureTextEntry = YES;
}
- (IBAction)buttonClick:(UIButton *)sender {
    if ([self.oldPwdText.text isEqualToString:@""]) {
        [self Alert:@"请输入旧密码"];
    }else if ([self.onePwdText.text isEqualToString:@""]){
        [self Alert:@"请输入新密码"];
    }else if ([self.twoPwdText.text isEqualToString:@""]){
        [self Alert:@"请输入再次输入新密码"];
    }else {
        [self Alert:@"保存成功!"];
    }

}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.oldPwdText resignFirstResponder];
    [self.onePwdText resignFirstResponder];
    [self.twoPwdText resignFirstResponder];
    // [self.textSummary resignFirstResponder];
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
