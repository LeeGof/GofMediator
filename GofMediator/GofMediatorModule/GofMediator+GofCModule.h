//
//  GofMediator+GofCModule.h
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator.h"

@interface GofMediator (GofCModule)

/**
 *  获取GofCViewController
 *
 *  @return GofCViewController
 */
- (UIViewController *)mediatorCViewController;

@end
