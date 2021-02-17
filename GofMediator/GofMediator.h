//
//  GofMediator.h
//  GofMediator_Example
//
//  Created by 李高峰 on 2021/2/17.
//  Copyright © 2021 LeeGof. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define KEPMediatorLog(s, ... ) NSLog( @"[%@：in line: %d]-->[message: %@]", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define KEPMediatorLog(s, ... )
#endif

#define KEPMediatorRunBlock(block, ...) if(block){block(__VA_ARGS__);}

extern NSString * _Nonnull const kMediatorSwiftModuleNameKey;

@interface GofMediator : NSObject

+ (instancetype _Nonnull)sharedInstance;

/// 远程调用入口
/// @param url url(统一格式示例：Gof://targetA/actionB?id=1234&name=Gof)
- (id _Nullable )gof_performRemoteActionWithUrl:(NSURL *_Nullable)url;

/// 本地调用入口
/// @param targetName 响应对象
/// @param actionName 响应方法
/// @param params 参数
- (id _Nullable )gof_performNativeWithTarget:(NSString *_Nullable)targetName
                                      action:(NSString *_Nullable)actionName
                                      params:(NSDictionary *_Nullable)params;

@end

