//
//  GofMediator+GofCModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator+GofCModule.h"

@implementation GofMediator (GofCModule)

/**
 *  获取GofCViewController
 *
 *  @return GofCViewController
 */
- (UIViewController *)mediatorCViewController
{
    UIViewController *viewController = [self performNativeWithTarget:@"C" action:@"CViewCtrlWithParam:" params:@{@"title": @"模块C"}];
    
    if ([viewController isKindOfClass:[UIViewController class]])
    {
        return viewController;
    }
    else  //处理异常
    {
        return nil;
    }
}

@end
