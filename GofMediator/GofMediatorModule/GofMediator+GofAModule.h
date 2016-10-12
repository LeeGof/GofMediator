//
//  GofMediator+GofAModule.h
//  A模块调度类
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator.h"

@interface GofMediator (GofAModule)

/**
 *  获取GofAViewController
 *
 *  @return GofAViewController
 */
- (UIViewController *)mediatorAViewController;

@end
