//
//  GofTargetBModule.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofTargetBModule.h"
#import "GofBViewController.h"
#import "GofConstant.h"

@implementation GofTargetBModule

/**
 *  获取GofBViewController
 *
 *  @param param 参数
 *
 *  @return GofBViewController
 */
- (UIViewController *)actionBViewCtrlWithParam:(NSDictionary *)param
{
    GofBViewController *vc = [[GofBViewController alloc] initWithTitle:param[@"title"]];
    return vc;
}

/**
 *  显示Alert
 *
 *  @param param 参数
 */
- (id)actionShowAlertWithParam:(NSDictionary *)param
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        GofDictionaryBlock callback = param[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction": action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GofDictionaryBlock callback = param[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction": action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:param[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    return nil;
}

@end
