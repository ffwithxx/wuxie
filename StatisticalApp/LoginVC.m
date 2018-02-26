//
//  LoginVC.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "LoginVC.h"
#import "BGControl.h"
#import "AFClient.h"
#import "SuperStudent.pch"

@interface LoginVC (){
    NSString *jizhu;
     NSMutableArray *postArr;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    postArr = [NSMutableArray new];
    [self first];
    // Do any additional setup after loading the view.
}
-(void)first{
    NSString *fileName = [BGControl filePath:@"UserInfo.plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:fileName];
    if (dict[@"jizhu"] == nil ||[dict[@"jizhu"] isEqualToString:@""] ) {
         jizhu = @"1";
        
    }else if ([dict[@"jizhu"] isEqualToString:@"1"]) {
        self.parentStore.text = dict[@"parentID"];
        self.sonStore.text = dict[@"sonStore"];
         self.pwdText.text = dict[@"psw"];
        jizhu = dict[@"jizhu"];
         _pwdImg.image = [UIImage imageNamed:@"img04"];
    }else {
        self.parentStore.text = @"";
        self.sonStore.text =@"";
        self.pwdText.text =@"";
        jizhu = dict[@"jizhu"];
        _pwdImg.image = [UIImage imageNamed:@"img03"];
    }
   
    self.parentStore.clearButtonMode = UITextFieldViewModeAlways;
    self.pwdText.clearButtonMode = UITextFieldViewModeAlways;
    self.pwdText.secureTextEntry = YES;
}
- (IBAction)loginClick:(UIButton *)sender {
    if ([self.parentStore.text isEqualToString:@""]) {
        [self Alert:@"请输入账号"];
    }else if ([self.pwdText.text isEqualToString:@""]){
        [self Alert:@"请输入密码"];
    }else {
        
        [self goLogin];
        
        NSString *fileName = [BGControl filePath:@"UserInfo.plist"];
        NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] init];
        saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"parentID" value:self.parentStore.text];
        saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"sonStore" value:self.sonStore.text];
        saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"psw" value:self.pwdText.text];
        saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"jizhu" value:jizhu];
        [saveDic writeToFile:fileName atomically:YES];
      
    }
}
-(void)goLogin {
     [self show];
    [[AFClient shareInstance] LoginByuserId:self.parentStore.text withPassword:self.pwdText.text withArr:postArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[responseBody valueForKey:@"data"]] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setValue:self.parentStore.text forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] setValue:self.pwdText.text forKey:@"account"];
                [[NSUserDefaults standardUserDefaults] setValue:self.pwdText.text forKey:@"Password"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"tMain" object:nil];
                [self dismiss];
        }else {
            NSString *str = [responseBody valueForKey:@"errors"];
            [self Alert:str];
           
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
        
        [self dismiss];
    }];
    
}

- (IBAction)changeClick:(UIButton *)sender {
    if ([jizhu isEqualToString:@"1"]) {
        jizhu = @"2";
        _pwdImg.image = [UIImage imageNamed:@"img03"];
        
    }else {
        jizhu = @"1";
        _pwdImg.image = [UIImage imageNamed:@"img04"];
    }
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    [self.parentStore resignFirstResponder];
    [self.sonStore resignFirstResponder];
    [self.pwdText resignFirstResponder];
    // [self.textSummary resignFirstResponder];
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
