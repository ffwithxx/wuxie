 //
//  TBViewController.m
//  GoToEat
//
//  Created by chenghong_mac on 15/9/14.
//  Copyright (c) 2015年 Bogo. All rights reserved.
//

#import "TBViewController.h"
#import "SuperStudent.pch"
#import "OneViewController.h"
#import "TwoViewController.h"


@interface TBViewController ()

@end

@implementation TBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = kTabBarColor;
    
    [self createViewControllers];
}


- (void)createViewControllers {
    //未选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kTextGrayColor,NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic"  size:12.0]} forState:UIControlStateNormal];
//    
//    //选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabBarColor,NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:12.0]} forState:UIControlStateSelected];
     [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTextGrayColor,UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTabBarColor,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CGRect frame = self.tabBar.frame;
//    frame.origin.y = 613;
    self.tabBar.frame = frame;
    
    OneViewController *oneVC = [storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    oneVC.tabBarItem.title = @"首页";
    
    oneVC.tabBarItem.image = [[UIImage imageNamed:@"a_0003_CALENDAR-_-ADD-副本"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    oneVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"a_0007_CALENDAR-_-ADD"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *oneNAV = [[UINavigationController alloc] initWithRootViewController:oneVC];
//    oneVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
//    healthVC.tabBarItem
    
//    CircleViewController *circleVC = [storyboard instantiateViewControllerWithIdentifier:@"CircleViewController"];
//    circleVC.tabBarItem.title = @"圈子";
//    NSLog(@"%f",  self.tabBar.frame.origin.y);
//    circleVC.tabBarItem.image = [[UIImage imageNamed:@"a_0001_SPEECH-BUBBLES-副本"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    circleVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"a_0005_SPEECH-BUBBLES"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UINavigationController * circleNAV = [[UINavigationController alloc] initWithRootViewController:circleVC];
//    circleVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
//    
    TwoViewController *twoVC = [storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
    twoVC.tabBarItem.title = @"发现";
    twoVC.tabBarItem.image = [[UIImage imageNamed:@"a_0002_VIEW-副本-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twoVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"a_0006_VIEW"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController * twoNAV = [[UINavigationController alloc] initWithRootViewController:twoVC];
//    twoVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    
    
    NSArray *tabArr = [[NSArray alloc] initWithObjects:oneNAV,twoNAV, nil];
    
    //self.viewControllers = tabArr;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:kTabBarColor];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
