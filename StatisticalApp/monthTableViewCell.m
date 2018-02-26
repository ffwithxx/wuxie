//
//  monthTableViewCell.m
//  StatisticalApp
//
//  Created by 冯丽 on 17/7/20.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "monthTableViewCell.h"
#import "SuperStudent.pch"
@implementation monthTableViewCell

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
