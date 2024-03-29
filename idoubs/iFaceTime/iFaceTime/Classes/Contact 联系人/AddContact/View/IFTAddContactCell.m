//
//  IFTAddContactCell.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/2.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTAddContactCell.h"

@interface IFTAddContactCell()

@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation IFTAddContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"IFTAddContactCell";
    IFTAddContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model indexPath:(nullable NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [_leftIV setImage:[UIImage imageNamed:@"ContactInPhone"]];
        _titleLabel.text = @"手机联系人";
    } else if (indexPath.row == 1) {
        [_leftIV setImage:[UIImage imageNamed:@"UpdateContact"]];
        _titleLabel.text = @"同步联系人";
    } else {
        [_leftIV setImage:[UIImage imageNamed:@"UpdateContactRecommend"]];
        _titleLabel.text = @"同步瞬加好友";
    }
}

@end
