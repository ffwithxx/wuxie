//
//  payTypeTableViewCell.h
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payTypeTableViewCell : UITableViewCell
//- (void)showModel:(zuoyeModel *)model;
//@property (strong, nonatomic)  UILabel *bigTypeLab;
//@property (strong, nonatomic)  UILabel *smallTypeLab;
//@property (strong, nonatomic)  UILabel *orderNumLab;
//@property (strong, nonatomic)  UILabel *priceLab;
//@property (strong, nonatomic)  UIView *bigView;
- (void)showDict:(NSDictionary *)dict ;
@end
