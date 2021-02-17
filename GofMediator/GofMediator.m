//
//  GofMediator.m
//  GofMediator_Example
//
//  Created by 李高峰 on 2021/2/17.
//  Copyright © 2021 LeeGof. All rights reserved.
//

#import "GofMediator.h"

NSString * const kMediatorSwiftModuleNameKey = @"kMediatorSwiftModuleNameKey";

@implementation GofMediator

+ (instancetype)sharedInstance {
    static GofMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[GofMediator alloc] init];
    });
    return mediator;
}

- (id _Nullable )gof_performRemoteActionWithUrl:(NSURL *_Nullable)url {
    if (url == nil) {
        return nil;
    }
    
    //解析参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];  //示例格式里的id=1234&name=LeeGof
    BOOL hasParam = NO;  // 是否有参数
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            continue;
        }
        hasParam = YES;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    //解析action
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];  //url.path：示例格式里的/actionB
    if (hasParam) {
        actionName = [actionName stringByAppendingString:@":"];
    }
    
    //统一入口方式响应
    id result = [self gof_performNativeWithTarget:url.host action:actionName params:params];
    
    return result;
}

- (id _Nullable )gof_performNativeWithTarget:(NSString *_Nullable)targetName
                                      action:(NSString *_Nullable)actionName
                                      params:(NSDictionary *_Nullable)params {
    if (!targetName || !actionName) {
        return [self p_noTargetActionResponseWithTarget:targetName action:actionName params:params];
    }
    
    // 获取 Target
    NSString *swiftModuleName = params[kMediatorSwiftModuleNameKey];
    NSString *targetClassString = nil;
    if (swiftModuleName.length > 0) {
        targetClassString = [NSString stringWithFormat:@"%@.GofTarget%@", swiftModuleName, targetName];
    } else {
        targetClassString = [NSString stringWithFormat:@"GofTarget%@", targetName];
    }
    Class targetClass = NSClassFromString(targetClassString);
    NSObject *target = [[targetClass alloc] init];
    
    // 获取 action
    NSString *actionString = [NSString stringWithFormat:@"action_%@", actionName];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {  //无响应类
        return [self p_noTargetActionResponseWithTarget:targetName action:actionName params:params];
    }
    
    if ([target respondsToSelector:action]) {
        return [self p_safePerformAction:action target:target params:params];
    } else {  //无响应方法
        return [self p_noTargetActionResponseWithTarget:targetName action:actionName params:params];
    }
}

#pragma mark - Private Method

- (id)p_noTargetActionResponseWithTarget:(NSString *)targetName
                                  action:(NSString *)actionName
                                  params:(NSDictionary *)params {
    KEPMediatorLog(@"targetName : %@ actionName : %@", targetName, actionName);
    return nil;
}

- (id)p_safePerformAction:(SEL)action target:(NSObject *)target params:(id)params {
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if(nil == methodSig) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}


@end
