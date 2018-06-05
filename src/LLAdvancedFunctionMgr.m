
#import "LLAdvancedFunctionMgr.h"

#define kArchiverFileDoc [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"WeChatRedEnvelopesHelperConfig"]

static NSString *const kLLIsOpenFilterMsgKey = @"kLLIsOpenFilterMsgKey";
static NSString *const kLLGroupFilterMsgSrcKey = @"kLLGroupFilterMsgSrcKey";
static NSString *const kLLPersonFilterMsgSrcKey = @"kLLPersonFilterMsgSrcKey";
static NSString *const kLLIsOpenVoiceTransmitKey = @"kLLIsOpenVoiceTransmitKey";

@implementation LLAdvancedFunctionMgr

+ (LLAdvancedFunctionMgr *)shared{
    static LLAdvancedFunctionMgr *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = kArchiverFileDoc;
        manager = [[LLAdvancedFunctionMgr alloc] init];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            @try{
                NSData *data = [NSData dataWithContentsOfFile:filePath];
                LLAdvancedFunctionMgr *cacheMgr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if(cacheMgr && [cacheMgr isKindOfClass:[LLAdvancedFunctionMgr class]]){
                    manager.isOpenFilterMsg = cacheMgr.isOpenFilterMsg;
                    manager.groupFilterMsgSrc = cacheMgr.groupFilterMsgSrc;
                    manager.personFilterMsgSrc = cacheMgr.personFilterMsgSrc;
                    manager.isOpenVoiceTransmit = cacheMgr.isOpenVoiceTransmit;
                }
            }  @catch (NSException *exception) {}
        }
    });
    return manager;
}

- (id)init{
    if (self = [super init]) {
        self.isOpenFilterMsg = NO;
        self.groupFilterMsgSrc = [NSMutableDictionary dictionary];
        self.personFilterMsgSrc = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.isOpenFilterMsg = [coder decodeBoolForKey:kLLIsOpenFilterMsgKey];
        self.groupFilterMsgSrc = [[coder decodeObjectForKey:kLLGroupFilterMsgSrcKey] mutableCopy];
        self.personFilterMsgSrc = [[coder decodeObjectForKey:kLLPersonFilterMsgSrcKey] mutableCopy];
        self.isOpenVoiceTransmit = [coder decodeBoolForKey:kLLIsOpenVoiceTransmitKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeBool:_isOpenFilterMsg forKey:kLLIsOpenFilterMsgKey];
    [coder encodeObject:_groupFilterMsgSrc forKey:kLLGroupFilterMsgSrcKey];
    [coder encodeObject:_personFilterMsgSrc forKey:kLLPersonFilterMsgSrcKey];
    [coder encodeBool:_isOpenVoiceTransmit forKey:kLLIsOpenVoiceTransmitKey];
}

- (void)updateMsgFilterConfigWithContact:(CContact *)contact key:(NSString *)key value:(id)value isGroup:(BOOL)isGroup{
    NSMutableDictionary *contactFilterSrc = [[isGroup?_groupFilterMsgSrc:_personFilterMsgSrc valueForKey:contact.m_nsUsrName]?:@{} mutableCopy];
    [contactFilterSrc setObject:value forKey:key];
    [isGroup?_groupFilterMsgSrc:_personFilterMsgSrc setObject:contactFilterSrc forKey:contact.m_nsUsrName];
    [self save];
}

- (void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    if (![data writeToFile:kArchiverFileDoc atomically:YES]) {
        //保存失败
    }
}

- (BOOL)isFilterMsgWithCMessage:(CMessageWrap *)message{
    if(message && [message isKindOfClass:NSClassFromString(@"CMessageWrap")]){
        CContactMgr *contactMgr = [[NSClassFromString(@"MMServiceCenter") defaultCenter] getService:NSClassFromString(@"CContactMgr")];
        CContact *fromContact = [contactMgr getContactByName:message.m_nsFromUsr];
        NSDictionary *filterConfig = nil;
        if([fromContact.m_nsUsrName containsString:@"@chatroom"]){
            //群组消息
            filterConfig = _groupFilterMsgSrc[fromContact.m_nsUsrName];
        } else {
            filterConfig = _personFilterMsgSrc[fromContact.m_nsUsrName];
        }
        if(!filterConfig){
            return NO;
        }
        if ([filterConfig[kLLIsOpenMsgFilter] boolValue]) {
            if(![filterConfig[kLLIsKeywordFilterMode] boolValue]){
                //所有消息过滤
                return YES;
            }
            //关键字过滤
            if (message.m_uiMessageType == 1) {
                //纯文本消息
                NSString *keywordStr = filterConfig[kLLMsgFilterKeyword];
                if(!keywordStr || ![keywordStr isKindOfClass:[NSString class]]){
                    return NO;
                }
                NSArray *keywords = [keywordStr componentsSeparatedByString:@","];
                BOOL isFindKeyword = NO;
                for (NSString *keyword in keywords) {
                    if([message.m_nsContent containsString:keyword]){
                        isFindKeyword = YES;
                        break;
                    }
                }
                return isFindKeyword;
            } else {
                return NO;
            }
        }
        return NO;
    }
    return NO;
}

@end
