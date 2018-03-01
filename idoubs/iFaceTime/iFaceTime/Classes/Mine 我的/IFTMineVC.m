/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  IFTMineVC.m
//  iFaceTime
//
//  Created by yesdgq on 2018/2/11.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "IFTMineVC.h"
#import "IFTMineHeaderView.h"
#import "IFTMineCellTwo.h"
#import "IFTMineCellOne.h"
#import "IFTContactDetailInfoVC.h"

@interface IFTMineVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *signOutButton;

@end

@implementation IFTMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    self.navigationItem.title = @"我的";
    
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setUpSubViews {
    [self.view addSubview:self.tableView];
    
    UIButton *signOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [signOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    signOutButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    signOutButton.titleLabel.textColor = [UIColor whiteColor];
    [signOutButton setBackgroundImage:[UIImage imageNamed:@"SignOutButtonBg"] forState:UIControlStateNormal];
    _signOutButton = signOutButton;
    [self.view addSubview:signOutButton];
    [signOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.top.equalTo(self.tableView.mas_bottom).offset(66);
        make.height.equalTo(@45);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        float height = IPHONE_X ? kMainScreenHeight-64-65-169:kMainScreenHeight-64-49-169;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        // tableHeaderView
        IFTMineHeaderView *headView = [[NSBundle mainBundle] loadNibNamed:@"IFTMineHeaderView" owner:nil options:nil][0];
        self.tableView.tableHeaderView = headView;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IFTMineCellOne *cell = [IFTMineCellOne cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    } else {
       IFTMineCellTwo *cell = [IFTMineCellTwo cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    }
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 60;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (IBAction)viewContactDetailInfo:(id)sender {
    IFTContactDetailInfoVC *contactInfoVC = [[IFTContactDetailInfoVC alloc] init];
    [self.navigationController pushViewController:contactInfoVC animated:YES];
}

- (IBAction)changeFeatureSwitchStatus:(id)sender {
    UISwitch *featureSwitch = sender;
    if (featureSwitch.isOn ) {
        if (featureSwitch.tag == 0) {
            DONG_Log(@"打开陌生人勿扰");
        } else {
            DONG_Log(@"打开家庭云账户");
        }
    } else {
        if (featureSwitch.tag == 0) {
            DONG_Log(@"关闭陌生人勿扰");
        } else {
            DONG_Log(@"关闭家庭云账户");
        }
    }
}

@end
