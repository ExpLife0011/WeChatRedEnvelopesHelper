#import "WCRedEnvelopesHelper.h"
#import "LLAdvancedFunctionMgr.h"

%hook VoiceMessageCellView

- (NSArray *)operationMenuItems{
	if(![LLAdvancedFunctionMgr shared].isOpenVoiceTransmit){
		return %orig;
	}
	NSMutableArray *menuItems = [%orig mutableCopy];
	UIMenuItem *voiceTransmitItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(doForward)];
	[menuItems insertObject:voiceTransmitItem atIndex:1];
	return menuItems;
}

%end

%hook ForwardMsgUtil

+ (void)ForwardMsg:(CMessageWrap *)msgWrap ToContact:(CContact *)forwardContact Scene:(unsigned int)scene forwardType:(unsigned int)type editImageAttr:(id)editImageAttr{
	if(![LLAdvancedFunctionMgr shared].isOpenVoiceTransmit){
		%orig;
		return;
	}
	if(msgWrap.m_uiMessageType == 0x22){ //语音消息类型
		BOOL isSender = [%c(CMessageWrap) isSenderFromMsgWrap:msgWrap];
		NSString *voicePath = [%c(CUtility) GetPathOfMesAudio:isSender ? msgWrap.m_nsToUsr : msgWrap.m_nsFromUsr LocalID:msgWrap.m_uiMesLocalID DocPath:[%c(CUtility) GetDocPath]]; 
		if([%c(CBaseFile) FileExist:voicePath]){
			CMessageWrap *newMsgWrap = [[%c(CMessageWrap) alloc] initWithMsgType:0x22];
			if(isSender){
				newMsgWrap.m_nsFromUsr = msgWrap.m_nsFromUsr; 
				newMsgWrap.m_nsToUsr = msgWrap.m_nsToUsr; 
			} else {
				newMsgWrap.m_nsFromUsr = msgWrap.m_nsToUsr; 
				newMsgWrap.m_nsToUsr = msgWrap.m_nsFromUsr; 
			}
			newMsgWrap.m_nsMsgSource = msgWrap.m_nsMsgSource; 
			newMsgWrap.m_uiStatus = 0x1;
			newMsgWrap.m_uiDownloadStatus = 0x9;
			MMNewSessionMgr *sessionMgr = [[%c(MMServiceCenter) defaultCenter] getService:%c(MMNewSessionMgr)];
			NSInteger genSendTime = [sessionMgr GenSendMsgTime];
			newMsgWrap.m_uiCreateTime = genSendTime;
			NSData *voiceData = [NSData dataWithContentsOfFile:voicePath];
			newMsgWrap.m_dtVoice = voiceData;
			newMsgWrap.m_uiVoiceFormat = msgWrap.m_uiVoiceFormat;
			newMsgWrap.m_uiVoiceTime = msgWrap.m_uiVoiceTime;
			[newMsgWrap UpdateContent:nil];
			CMessageMgr *msgMgr = [[%c(MMServiceCenter) defaultCenter] getService:%c(CMessageMgr)];
			[msgMgr AddLocalMsg:forwardContact.m_nsUsrName MsgWrap:newMsgWrap]; 
			newMsgWrap.m_uiDownloadStatus = 0x9;
			AudioSender *audioSender = [[%c(MMServiceCenter) defaultCenter] getService:%c(AudioSender)];
			MMNewUploadVoiceMgr *uploadVoiceMgr = MSHookIvar<MMNewUploadVoiceMgr *>(audioSender,"m_upload");
			[uploadVoiceMgr ResendVoiceMsg:forwardContact.m_nsUsrName MsgWrap:newMsgWrap];
		}
	} else {
		%orig;
	}
}

%end
