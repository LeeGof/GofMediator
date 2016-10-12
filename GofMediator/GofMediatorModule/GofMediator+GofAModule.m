//
//  GofMediator+GofAModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator+GofAModule.h"

@implementation GofMediator (GofAModule)

/**
 *  获取GofAViewController
 *
 *  @return GofAViewController
 */
- (UIViewController *)mediatorAViewController
{
    UIViewController *viewController = [self performNativeWithTarget:@"A" action:@"AViewCtrlWithParam:" params:@{@"title": @"模块A"}];
    
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
