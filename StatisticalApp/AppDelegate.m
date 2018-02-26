//
//  AppDelegate.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AppDelegate.h"
#import "OneViewController.h"
//#import "TBViewController.h"
#import "TwoViewController.h"
#import "LoginVC.h"
@interface AppDelegate () {
//TBViewController *_tbViewController;
    
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * ctrl = (UIViewController *)[storyboard instantiateInitialViewController];
//    self.window.rootViewController = ctrl;
    LoginVC *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginPage:) name:@"tMain" object:nil];
    return YES;
}

- (void)loginPage:(id)sender {
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneViewController *oneVC =[storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:oneVC];
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
