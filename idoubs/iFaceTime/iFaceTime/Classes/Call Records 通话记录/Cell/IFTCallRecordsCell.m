//
//  IFTCallRecordsCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/25.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTCallRecordsCell.h"

@implementation IFTCallRecordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTCallRecordsCell";
    IFTCallRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
