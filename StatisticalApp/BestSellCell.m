//
//  BestSellCell.m
//  StatisticalApp
//
//  Created by 冯丽 on 2017/11/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BestSellCell.h"

@implementation BestSellCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {
    self.dateLabel.font =[UIFont systemFontOfSize:15];
    
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
