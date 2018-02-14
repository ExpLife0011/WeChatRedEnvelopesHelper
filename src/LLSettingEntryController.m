//
//  LLSettingEntryController.m
//  WeChatRedEnvelopesHelper
//
//  Created by a on 2018/2/9.
//  Copyright © 2018年 kevliule. All rights reserved.
//

#import "LLSettingEntryController.h"
#import "WCRedEnvelopesHelper.h"
#import "LLRedEnvelopesMgr.h"
#import "LLSettingController.h"

@interface LLSettingEntryController ()

@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;

@end

@implementation LLSettingEntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableView];
    [self reloadTableData];
}

- (void)setNavigationBar{
    self.title = @"微信助手设置";
}

- (void)setTableView{
    _tableViewInfo = [[NSClassFromString(@"MMTableViewInfo") alloc] initWithFrame:[UIScreen mainScreen].bounds style:0];
    [self.view addSubview:[_tableViewInfo getTableView]];
    [_tableViewInfo setDelegate:self];
    if (@available(iOS 11, *)) {
        [_tableViewInfo getTableView].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    }else{
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)reloadTableData{
    MMTableViewCellInfo *redEnvelopesCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onRedEnvelopesCellClicked) target:self title:@"微信助手设置" rightValue:nil accessoryType:1];
    MMTableViewCellInfo *totalAssistAmountCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:nil target:self title:@"累计帮您领取红包" rightValue:[NSString stringWithFormat:@"%.2f元",[LLRedEnvelopesMgr shared].totalAssistAmount / 100.0f] accessoryType:0];

    MMTableViewSectionInfo *wechatSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [wechatSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [wechatSection addCell:redEnvelopesCell];
    [wechatSection addCell:totalAssistAmountCell];

    MMTableViewCellInfo *githubCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onGithubCellClicked) target:self title:@"我的Github" rightValue:@"欢迎⭐️" accessoryType:1];
    MMTableViewCellInfo *blogCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onBlogCellClicked) target:self title:@"我的博客" rightValue:nil accessoryType:1];
    MMTableViewCellInfo *rewardCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onRewardCellClicked) target:self title:@"打赏作者" rightValue:@"请我喝杯☕️" accessoryType:1];

    MMTableViewSectionInfo *aboutMeSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [aboutMeSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [aboutMeSection addCell:githubCell];
    [aboutMeSection addCell:blogCell];
    [aboutMeSection addCell:rewardCell];
    
    [_tableViewInfo clearAllSection];
     [_tableViewInfo addSection:wechatSection];
    [_tableViewInfo addSection:aboutMeSection];

    [[_tableViewInfo getTableView] reloadData];
}

- (void)onRedEnvelopesCellClicked{
    LLSettingController *settingVC = [[LLSettingController alloc] init];
    [self.navigationController PushViewController:settingVC animated:YES];
}

- (void)onGithubCellClicked{
    NSURL *myGithubURL = [NSURL URLWithString:@"https://github.com/kevll/WeChatRedEnvelopesHelper"];
    MMWebViewController *githubWebVC = [[NSClassFromString(@"MMWebViewController") alloc] initWithURL:myGithubURL presentModal:NO extraInfo:nil delegate:nil];
    [self.navigationController PushViewController:githubWebVC animated:YES];
}

- (void)onBlogCellClicked{
    NSURL *myGithubURL = [NSURL URLWithString:@"https://kevll.github.io/"];
    MMWebViewController *githubWebVC = [[NSClassFromString(@"MMWebViewController") alloc] initWithURL:myGithubURL presentModal:NO extraInfo:nil delegate:nil];
    [self.navigationController PushViewController:githubWebVC animated:YES];
}

- (void)onRewardCellClicked{
    NSURL *myGithubURL = [NSURL URLWithString:@"https://kevll.github.io/reward.html"];
    MMWebViewController *githubWebVC = [[NSClassFromString(@"MMWebViewController") alloc] initWithURL:myGithubURL presentModal:NO extraInfo:nil delegate:nil];
    [self.navigationController PushViewController:githubWebVC animated:YES];
}

@end
