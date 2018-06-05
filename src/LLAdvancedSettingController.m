
#import "WCRedEnvelopesHelper.h"
#import "LLAdvancedSettingController.h"
#import "LLAdvancedFunctionMgr.h"

@interface LLAdvancedSettingController ()

@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;

@end

@implementation LLAdvancedSettingController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableView];
	[self reloadTableData];
}

- (void)setNavigationBar{
    self.title = @"高级功能设置";
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
	MMTableViewCellInfo *openFilterMessageCell = [NSClassFromString(@"MMTableViewCellInfo") switchCellForSel:@selector(openFilterMessageSwitchHandler:) target:self title:@"消息过滤全局开关" on:[LLAdvancedFunctionMgr shared].isOpenFilterMsg];
    MMTableViewCellInfo *openVoiceTransmitCell = [NSClassFromString(@"MMTableViewCellInfo") switchCellForSel:@selector(openVoiceTransmitSwitchHandler:) target:self title:@"是否开启语音转发功能" on:[LLAdvancedFunctionMgr shared].isOpenVoiceTransmit];
    
    MMTableViewSectionInfo *filterMsgSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [filterMsgSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [filterMsgSection setFooterTitle:@"如需使用消息过滤功能，请开启全局开关。"];
    [filterMsgSection addCell:openFilterMessageCell];
    
    MMTableViewSectionInfo *voiceTransmitSection = [NSClassFromString(@"MMTableViewSectionInfo") sectionInfoDefaut];
    [voiceTransmitSection setHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,20)]];
    [voiceTransmitSection setFooterTitle:@"如需使用语音转发功能，请开启开关。"];
    [voiceTransmitSection addCell:openVoiceTransmitCell];
    
    [_tableViewInfo clearAllSection];
    [_tableViewInfo addSection:filterMsgSection];
    [_tableViewInfo addSection:voiceTransmitSection];
    
    [[_tableViewInfo getTableView] reloadData];
}

- (void)openFilterMessageSwitchHandler:(UISwitch *)aSwitch{
    [LLAdvancedFunctionMgr shared].isOpenFilterMsg = aSwitch.on;
    [[LLAdvancedFunctionMgr shared] save];
}

- (void)openVoiceTransmitSwitchHandler:(UISwitch *)aSwitch{
    [LLAdvancedFunctionMgr shared].isOpenVoiceTransmit = aSwitch.on;
    [[LLAdvancedFunctionMgr shared] save];
}

@end
