//
//  payTypeTableViewCell.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "payTypeTableViewCell.h"
#import "SuperStudent.pch"
#import "BGControl.h"

@implementation payTypeTableViewCell {

}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCell];
    }
    return self;
}
- (void)customCell {
    
//    @property (strong, nonatomic)  UILabel *bigTypeLab;
//    @property (strong, nonatomic)  UILabel *smallTypeLab;
//    @property (strong, nonatomic)  UILabel *orderNumLab;
//    @property (strong, nonatomic)  UILabel *priceLab;
    

//    _bigTypeLab = [UILabel new];
//    _bigTypeLab.font = [UIFont systemFontOfSize:15];
//    [_bigView addSubview:_bigTypeLab];
//    
//    _smallTypeLab = [UILabel new];
//    _smallTypeLab.font = [UIFont systemFontOfSize:15];
//    [_bigView addSubview:_smallTypeLab];
//    
//    _orderNumLab = [UILabel new];
//    _orderNumLab.font = [UIFont systemFontOfSize:15];
//    [_bigView addSubview:_orderNumLab];
//    
//    _priceLab = [UILabel new];
//    _priceLab.font = [UIFont systemFontOfSize:15];
//    [_bigView addSubview:_priceLab];
    
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    //    self.contentView.backgroundColor = kTabBarColor;
}
- (void)showDict:(NSDictionary *)dict {
    for (UIView *view in [self.contentView subviews]) {
        if (view.tag ==1001) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat Width = ( kScreenSize.width - 30 ) / 4;
    NSArray *arr = [dict valueForKey:@"smallArr"];
    CGFloat hei = 0;
    for (int i = 0; i < arr.count; i++) {
        UILabel *bigTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0+40*i, Width, 40)];
        bigTypeLab.font = [UIFont systemFontOfSize:15];
        bigTypeLab.tag = 1001;
        if (i==0) {
              bigTypeLab.text = [arr[i] valueForKey:@"bigName"];
        }
      
        bigTypeLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView  addSubview:bigTypeLab];
        
        UILabel *smallTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(15+Width, 0+40*i, Width, 40)];
        smallTypeLab.font = [UIFont systemFontOfSize:15];
         smallTypeLab.text = [arr[i] valueForKey:@"name"];
         smallTypeLab.textAlignment = NSTextAlignmentCenter;
        smallTypeLab.tag = 1001;
        [self.contentView  addSubview:smallTypeLab];
        
        UILabel *orderLab = [[UILabel alloc] initWithFrame:CGRectMake(15+Width*2, 0+40*i, Width, 40)];
        orderLab.font = [UIFont systemFontOfSize:15];
        orderLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:[arr[i]valueForKey:@"order"] afterPoint:2]];
         orderLab.textAlignment = NSTextAlignmentCenter;
          orderLab.tag = 1001;
        [self.contentView  addSubview:orderLab];
        
        UILabel *priceTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(15+Width*3, 0+40*i, Width, 40)];
        priceTypeLab.font = [UIFont systemFontOfSize:15];
         priceTypeLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:[arr[i]valueForKey:@"money"] afterPoint:2]];
        priceTypeLab.textAlignment = NSTextAlignmentRight;
          priceTypeLab.tag = 1001;
        [self.contentView addSubview:priceTypeLab];
      hei = hei + 40;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, hei-1, kScreenSize.width, 1)];
        lineView.backgroundColor = kDarkGrayColor;
        lineView.tag = 1001;
        if (i == arr.count-1) {
          
            [self.contentView addSubview:lineView];
        }
    }
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
