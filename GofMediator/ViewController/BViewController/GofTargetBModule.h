//
//  GofTargetBModule.h
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GofTargetBModule : NSObject

/**
 *  获取GofBViewController
 *
 *  @param param 参数
 *
 *  @return GofBViewController
 */
- (UIViewController *)actionBViewCtrlWithParam:(NSDictionary *)param;

/**
 *  显示Alert
 *
 *  @param param 参数
 */
- (id)actionShowAlertWithParam:(NSDictionary *)param;

@end
