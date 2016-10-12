//
//  GofMediator.h
//  中间件类
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GofMediator : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程调用
 *
 *  @param url url(统一格式示例：Gof://targetA/actionB?id=1234&name=LeeGof)
 *
 *  @return YES/NO
 */
- (BOOL)performRemoteActionWithUrl:(NSURL *)url;

/**
 *  本地调用
 *
 *  @param target 响应者
 *  @param action 动作
 *  @param params 参数
 *
 *  @return id类型
 */
- (id)performNativeWithTarget:(NSString *)target
                       action:(NSString *)action
                       params:(NSDictionary *)params;

@end
