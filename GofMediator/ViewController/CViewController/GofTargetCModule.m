//
//  GofTargetCModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofTargetCModule.h"
#import "GofCViewController.h"

@implementation GofTargetCModule

/**
 *  获取GofCViewController
 *
 *  @param param 参数
 *
 *  @return GofCViewController
 */
- (UIViewController *)actionCViewCtrlWithParam:(NSDictionary *)param
{
    GofCViewController *vc = [[GofCViewController alloc] initWithTitle:param[@"title"]];
    return vc;
}

@end
