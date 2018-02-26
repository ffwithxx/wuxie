//
//  saleTableViewCell.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/20.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "saleTableViewCell.h"
#import "SuperStudent.pch"
@implementation saleTableViewCell{
    UIView *bigView;
    UILabel * typeLabel;
    UILabel *priceLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCell];
    }
    return self;
}
- (void)customCell {
    bigView = [UIView new];
    [self.contentView addSubview:bigView];
    bigView.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    typeLabel = [UILabel new];
    [bigView addSubview:typeLabel];
    priceLabel = [UILabel new];
    [bigView addSubview:priceLabel];
    typeLabel.textColor = [UIColor blackColor];
    priceLabel.textColor = [UIColor blackColor];
    typeLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.font = [UIFont systemFontOfSize:14];
    typeLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    
}
- (void)layoutSubviews {
    bigView.frame = CGRectMake(0, 0, kScreenSize.width, 30);
    typeLabel.frame = CGRectMake(15, 0, (kScreenSize.width-30)/2, 30);
    priceLabel.frame = CGRectMake((kScreenSize.width-30)/2+15, 0, (kScreenSize.width-30)/2, 30);
    [super layoutSubviews];
}
- (void)showModel{
    typeLabel.text= @"奶茶";
    priceLabel.text = @"5566";
    
    //    CGSize zuoyeLabSize;
    //   zuoyeLabSize.height = [self heightForString:zuoyeLab.text fontSize:14 andWidth:kScreenSize.width-162];
    //    zuoyeLab.frame = CGRectMake(CGRectGetMaxX(kemuLab.frame), 0, kScreenSize.width-162, zuoyeLabSize.height);
    //    [selectButton addTarget:selectButton action:@selector(buttonClc:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
