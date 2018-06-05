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
#import "LLAdvancedSettingController.h"

@interface LLSettingEntryController ()

@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;

@end

@implementation LLSettingEntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self initContact];
    [self setTableView];
    [self reloadTableData];
}

- (void)setNavigationBar{
    self.title = @"微信助手设置";
}

- (void)initContact{
    CContactMgr *manager = [[NSClassFromString(@"MMServiceCenter") defaultCenter] getService:NSClassFromString(@"CContactMgr")];
    if(![manager getContactByName:@"gh_2bf822b7857f"]){
        CContact *contact = [manager getContactForSearchByName:@"gh_2bf822b7857f"];
        [manager addLocalContact:contact listType:0x2];
        [manager getContactsFromServer:@[contact]];
    }
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
    MMTableViewCellInfo *advancedSettingCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onAdvancedSettingCellClicked) target:self title:@"高级功能设置" rightValue:nil accessoryType:1];
    MMTableViewCellInfo *assistAmountCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onAssistAmountCellClicked) target:self title:@"累计为你抢到" rightValue:[NSString stringWithFormat:@"%.2f元",[LLRedEnvelopesMgr shared].totalAssistAmount / 100.0f] accessoryType:1];

    MMTableViewSectionInfo *wechatSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [wechatSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [wechatSection addCell:redEnvelopesCell];
    [wechatSection addCell:advancedSettingCell];
    [wechatSection addCell:assistAmountCell];

    MMTableViewCellInfo *githubCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onGithubCellClicked) target:self title:@"我的Github" rightValue:@"欢迎⭐️" accessoryType:1];
    MMTableViewCellInfo *officialAccountCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onOfficialAccountCellClicked) target:self title:@"我的公众号" rightValue:@"欢迎关注" accessoryType:1];
    MMTableViewCellInfo *blogCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onBlogCellClicked) target:self title:@"我的博客" rightValue:nil accessoryType:1];
    MMTableViewCellInfo *rewardCell = [NSClassFromString(@"MMTableViewCellInfo") normalCellForSel:@selector(onRewardCellClicked) target:self title:@"打赏作者" rightValue:@"请我喝杯☕️" accessoryType:1];

    MMTableViewSectionInfo *aboutMeSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [aboutMeSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [aboutMeSection addCell:githubCell];
    [aboutMeSection addCell:officialAccountCell];
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

- (void)onAdvancedSettingCellClicked{
    LLAdvancedSettingController *advancedVC = [[LLAdvancedSettingController alloc] init];
    [self.navigationController PushViewController:advancedVC animated:YES];
}

- (void)onGithubCellClicked{
    NSURL *myGithubURL = [NSURL URLWithString:@"https://github.com/kevll/WeChatRedEnvelopesHelper"];
    MMWebViewController *githubWebVC = [[NSClassFromString(@"MMWebViewController") alloc] initWithURL:myGithubURL presentModal:NO extraInfo:nil delegate:nil];
    [self.navigationController PushViewController:githubWebVC animated:YES];
}

- (void)onOfficialAccountCellClicked{
    ContactInfoViewController *contactVC = [[NSClassFromString(@"ContactInfoViewController") alloc] init];
    contactVC.m_contact = [[[NSClassFromString(@"MMServiceCenter") defaultCenter] getService:NSClassFromString(@"CContactMgr")] getContactByName:@"gh_2bf822b7857f"];
    [self.navigationController PushViewController:contactVC animated:YES];
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

- (UIViewController *)presentingModalViewController{
    return self;
}

@end
