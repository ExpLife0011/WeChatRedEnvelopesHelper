
#import <UIKit/UIKit.h>
#import "WCRedEnvelopesHelper.h"

static NSString *const kLLIsOpenMsgFilter = @"kLLIsOpenMsgFilter";
static NSString *const kLLIsKeywordFilterMode = @"kLLIsKeywordFilterMode";
static NSString *const kLLMsgFilterKeyword = @"kLLMsgFilterKeyword";

@interface LLAdvancedFunctionMgr : NSObject

@property (nonatomic, assign) BOOL isOpenFilterMsg; //是否打开过滤消息
@property (nonatomic, strong) NSMutableDictionary *groupFilterMsgSrc; //@{@"groupId":@{@"type":@"1/2",@"filterKey":@"key1,key2,key3"}}
@property (nonatomic, strong) NSMutableDictionary *personFilterMsgSrc; //@{@"groupId":@{@"type":@"1/2",@"filterKey":@"key1,key2,key3"}}

@property (nonatomic, assign) BOOL isOpenVoiceTransmit; //是否开启语音转发功能

+ (LLAdvancedFunctionMgr *)shared;

//更新消息过滤配置
- (void)updateMsgFilterConfigWithContact:(CContact *)contact key:(NSString *)key value:(id)value isGroup:(BOOL)isGroup;

//是否过滤消息
- (BOOL)isFilterMsgWithCMessage:(CMessageWrap *)message;

//序列化存储到沙盒
- (void)save;

@end
