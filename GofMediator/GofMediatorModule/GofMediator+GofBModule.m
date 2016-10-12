//
//  GofMediator+GofBModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator+GofBModule.h"

@implementation GofMediator (GofBModule)

- (UIViewController *)mediatorBViewController
{
    UIViewController *viewController = [self performNativeWithTarget:@"B" action:@"BViewCtrlWithParam:" params:@{@"title": @"模块B"}];
    
    if ([viewController isKindOfClass:[UIViewController class]])
    {
        return viewController;
    }
    else  //处理异常
    {
        return nil;
    }
}

- (void)showAlertWithWithMessage:(NSString *)message
                    cancelAction:(void(^)(NSDictionary *info))cancelAction
                   confirmAction:(void(^)(NSDictionary *info))confirmAction
{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    [self performNativeWithTarget:@"B"
                           action:@"ShowAlertWithParam:"
                           params:paramsToSend];
}

@end
