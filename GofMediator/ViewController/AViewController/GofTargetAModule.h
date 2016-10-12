//
//  GofTargetAModule.h
//  A模块Target-Action
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GofTargetAModule : NSObject

/**
 *  获取GofAViewController
 *
 *  @param param 参数
 *
 *  @return GofAViewController
 */
- (UIViewController *)actionAViewCtrlWithParam:(NSDictionary *)param;

@end
