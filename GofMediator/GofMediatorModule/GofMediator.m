//
//  GofMediator.m
//  调度者类
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator.h"

@implementation GofMediator

+ (instancetype)sharedInstance
{
    static GofMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[GofMediator alloc] init];
    });
    return mediator;
}

/**
 *  远程调用
 *
 *  @param url url(统一格式示例：Gof://targetA/actionB?id=1234&name=LeeGof)
 *
 *  @return YES/NO
 */
- (BOOL)performRemoteActionWithUrl:(NSURL *)url
{
    if (![url.scheme isEqualToString:@"Gof"])
    {
        //这里可以跳转到一个错误页面
        return NO;
    }
    
    //解析参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];  //示例格式里的id=1234&name=LeeGof
    for (NSString *param in [urlString componentsSeparatedByString:@"&"])
    {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2)
        {
            continue;
        }
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    //解析action
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];  //url.path：示例格式里的/actionB
    if ([actionName hasPrefix:@"native"])  //这里做安全校验，防止黑客用远程方式调用本地模块
    {
        return NO;
    }
    
    //解析target
    NSString *target = url.host;
    
    //统一入口方式响应
    id result = [self performNativeWithTarget:target action:actionName params:params];
    
    if (result)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return YES;
}

/**
 *  本地调用
 *
 *  @param targetName 响应者
 *  @param actionName 动作
 *  @param params     参数
 *
 *  @return id类型
 */
- (id)performNativeWithTarget:(NSString *)targetName
                       action:(NSString *)actionName
                       params:(NSDictionary *)params
{
    NSString *targetClassString = [NSString stringWithFormat:@"GofTarget%@Module", targetName];
    NSString *actionString = [NSString stringWithFormat:@"action%@", actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil)  //没有响应者
    {
        //跳转到一个公用错误页面
        return [[NSClassFromString(@"GofDefaultViewController") alloc] init];
    }
    
    if ([target respondsToSelector:action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
    else  //无响应
    {
        //跳转到一个公用错误页面
        return [[NSClassFromString(@"GofDefaultViewController") alloc] init];
    }
}

@end
