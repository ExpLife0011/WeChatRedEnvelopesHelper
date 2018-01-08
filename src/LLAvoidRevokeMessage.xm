#import "LLRedEnvelopesMgr.h"

%hook CMessageMgr

- (void)onRevokeMsg:(id)message{
	if([LLRedEnvelopesMgr shared].isOpenAvoidRevokeMessage){
		return;
	}
	%orig;
}

%end
