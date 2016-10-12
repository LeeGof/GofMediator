//
//  GofMediator+GofBModule.h
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofMediator.h"

@interface GofMediator (GofBModule)

/**
 *  获取GofBViewController
 *
 *  @return GofBViewController
 */
- (UIViewController *)mediatorBViewController;

/**
 *  显示Alert框
 *
 *  @param message       标题
 *  @param cancelAction  取消按钮
 *  @param confirmAction 确定按钮
 */
- (void)showAlertWithWithMessage:(NSString *)message
                    cancelAction:(void(^)(NSDictionary *info))cancelAction
                   confirmAction:(void(^)(NSDictionary *info))confirmAction;

@end
