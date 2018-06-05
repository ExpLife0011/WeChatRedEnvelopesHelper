#import "WCRedEnvelopesHelper.h"
#import "LLAdvancedFunctionMgr.h"

%ctor{
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isHookBundleId"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

%hook MicroMessengerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	BOOL a = %orig;
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isHookBundleId"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	return a;
}

%end

%hook NSBundle


- (NSString *)bundleIdentifier{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isHookBundleId"]) {
        return @"com.tencent.xin";
    } 
	return %orig;
}

- (NSDictionary *)infoDictionary{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isHookBundleId"]) {
		NSMutableDictionary *infoDic = [%orig mutableCopy];
		[infoDic setObject:@"com.tencent.xin" forKey:@"CFBundleIdentifier"];
		return infoDic;
	}
	return %orig;
}

- (id)objectForInfoDictionaryKey:(NSString *)key{
	if([key isEqualToString:@"CFBundleIdentifier"] && [[NSUserDefaults standardUserDefaults] boolForKey:@"isHookBundleId"]){
		return @"com.tencent.xin";
	} 
	return %orig;
}

%end

%hook ChatRoomInfoViewController

- (void)reloadTableData{
	%orig;
	LLAdvancedFunctionMgr *manager = [LLAdvancedFunctionMgr shared];
	NSDictionary *groupFilterSrc = [manager.groupFilterMsgSrc valueForKey:self.m_chatRoomContact.m_nsUsrName];
    MMTableViewCellInfo *switchMsgFilterCell = [%c(MMTableViewCellInfo) switchCellForSel:@selector(switchMsgFilter:) target:self title:@"消息过滤" on:[groupFilterSrc[kLLIsOpenMsgFilter] boolValue]];
    MMTableViewCellInfo *msgFilterModeCell = [%c(MMTableViewCellInfo) switchCellForSel:@selector(switchMsgFilterMode:) target:self title:@"过滤模式" on:[groupFilterSrc[kLLIsKeywordFilterMode] boolValue]];
    MMTableViewCellInfo *filterKeyCell = [%c(MMTableViewCellInfo) editorCellForSel:@selector(filterKeyEditChange:) target:self title:@"过滤关键字" margin:100 tip:@"英文逗号分隔" focus:NO autoCorrect:NO text:groupFilterSrc[kLLMsgFilterKeyword] isFitIpadClassic:YES];
    MMTableViewSectionInfo *sectionInfo = [%c(MMTableViewSectionInfo) sectionInfoDefaut];
    [sectionInfo setFooterTitle:@"1.过滤模式开关打开为关键字过滤模式，关闭为完全屏蔽模式;\n\n2.如果有多个需要过滤的关键字，用\"英式\"逗号进行分隔;\n\n3.如使用过滤功能，请先前往\"高级功能设置\"开启\"消息过滤全局开关\"；关闭开关则全局关闭过滤。"];
    [sectionInfo addCell:switchMsgFilterCell];
    [sectionInfo addCell:msgFilterModeCell];
    [sectionInfo addCell:filterKeyCell];
    MMTableViewInfo *tableViewInfo = [self valueForKey:@"m_tableViewInfo"];
    [tableViewInfo insertSection:sectionInfo At:4];
    [[tableViewInfo getTableView] reloadData];
}

%new
- (void)switchMsgFilter:(UISwitch *)aSwitch{
    [[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_chatRoomContact key:kLLIsOpenMsgFilter value:@(aSwitch.on) isGroup:YES];
}

%new
- (void)switchMsgFilterMode:(UISwitch *)aSwitch{
	[[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_chatRoomContact key:kLLIsKeywordFilterMode value:@(aSwitch.on) isGroup:YES];
}

%new
- (void)filterKeyEditChange:(UITextField *)textField{
	[[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_chatRoomContact key:kLLMsgFilterKeyword value:textField.text?:@"" isGroup:YES];
}

%end

%hook AddContactToChatRoomViewController

- (void)reloadTableData{
	%orig;
	LLAdvancedFunctionMgr *manager = [LLAdvancedFunctionMgr shared];
	NSDictionary *groupFilterSrc = [manager.personFilterMsgSrc valueForKey:self.m_contact.m_nsUsrName];
    MMTableViewCellInfo *switchMsgFilterCell = [%c(MMTableViewCellInfo) switchCellForSel:@selector(switchMsgFilter:) target:self title:@"消息过滤" on:[groupFilterSrc[kLLIsOpenMsgFilter] boolValue]];
    MMTableViewCellInfo *msgFilterModeCell = [%c(MMTableViewCellInfo) switchCellForSel:@selector(switchMsgFilterMode:) target:self title:@"过滤模式" on:[groupFilterSrc[kLLIsKeywordFilterMode] boolValue]];
    MMTableViewCellInfo *filterKeyCell = [%c(MMTableViewCellInfo) editorCellForSel:@selector(filterKeyEditChange:) target:self title:@"过滤关键字" margin:100 tip:@"英文逗号分隔" focus:NO autoCorrect:NO text:groupFilterSrc[kLLMsgFilterKeyword] isFitIpadClassic:YES];
    MMTableViewSectionInfo *sectionInfo = [%c(MMTableViewSectionInfo) sectionInfoDefaut];
    [sectionInfo setFooterTitle:@"1.过滤模式开关打开为关键字过滤模式，关闭为完全屏蔽模式;\n\n2.如果有多个需要过滤的关键字，用\"英式\"逗号进行分隔;\n\n3.如使用过滤功能，请先前往\"高级功能设置\"开启\"消息过滤全局开关\"；关闭开关则全局关闭过滤。"];
    [sectionInfo addCell:switchMsgFilterCell];
    [sectionInfo addCell:msgFilterModeCell];
    [sectionInfo addCell:filterKeyCell];
    MMTableViewInfo *tableViewInfo = [self valueForKey:@"m_tableViewInfo"];
    [tableViewInfo insertSection:sectionInfo At:3];
    [[tableViewInfo getTableView] reloadData];
}

%new
- (void)switchMsgFilter:(UISwitch *)aSwitch{
    [[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_contact key:kLLIsOpenMsgFilter value:@(aSwitch.on) isGroup:NO];
}

%new
- (void)switchMsgFilterMode:(UISwitch *)aSwitch{
	[[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_contact key:kLLIsKeywordFilterMode value:@(aSwitch.on) isGroup:NO];
}

%new
- (void)filterKeyEditChange:(UITextField *)textField{
	[[LLAdvancedFunctionMgr shared] updateMsgFilterConfigWithContact:self.m_contact key:kLLMsgFilterKeyword value:textField.text?:@"" isGroup:NO];
}

%end

%hook SyncCmdHandler

- (void)BatchAddMsg:(id)msgList ShowPush:(id)arg{
	if(![LLAdvancedFunctionMgr shared].isOpenFilterMsg){
		%orig;
		return;
	}
	int i = 0;
	NSArray *arrMsgList = MSHookIvar<NSArray *>(self,"m_arrMsgList");
	NSMutableArray *mutableArrMsgList= [arrMsgList mutableCopy];
	for(CMessageWrap *msg in arrMsgList){
		if([[LLAdvancedFunctionMgr shared] isFilterMsgWithCMessage:msg]){
    		[mutableArrMsgList removeObjectAtIndex:i];
    	}
    	i++;
	}
	[self setValue:mutableArrMsgList forKey:@"m_arrMsgList"];
	%orig;
}

%end
