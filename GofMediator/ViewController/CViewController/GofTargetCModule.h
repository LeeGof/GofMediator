//
//  GofTargetCModule.h
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GofTargetCModule : NSObject

/**
 *  获取GofCViewController
 *
 *  @param param 参数
 *
 *  @return GofCViewController
 */
- (UIViewController *)actionCViewCtrlWithParam:(NSDictionary *)param;

@end
