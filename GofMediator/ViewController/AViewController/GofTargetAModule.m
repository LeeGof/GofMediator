//
//  GofTargetAModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofTargetAModule.h"
#import "GofAViewController.h"

@implementation GofTargetAModule

/**
 *  获取GofAViewController
 *
 *  @param param 参数
 *
 *  @return GofAViewController
 */
- (UIViewController *)actionAViewCtrlWithParam:(NSDictionary *)param
{
    GofAViewController *vc = [[GofAViewController alloc] initWithTitle:param[@"title"]];
    return vc;
}

@end
