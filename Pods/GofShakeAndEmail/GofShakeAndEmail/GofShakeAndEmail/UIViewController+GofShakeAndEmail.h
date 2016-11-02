//
//  UIViewController+GofShakeAndEmail.h
//  GofShakeAndEmail
//
//  Created by LeeGof on 2016/10/17.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>

@interface UIViewController (GofShakeAndEmail)<MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,UIGestureRecognizerDelegate>

@end
