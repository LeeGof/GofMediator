//
//  UIViewController+GofShakeAndEmail.m
//  GofShakeAndEmail
//
//  Created by LeeGof on 2016/10/17.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "UIViewController+GofShakeAndEmail.h"

@implementation UIViewController (GofShakeAndEmail)

#pragma mark - 摇一摇动作处理

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"began");
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"cancel");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"end");
    
//    [self cutterViewToDocument];
}

#pragma mark - 截屏

- (void)cutterViewToDocument
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *screenShotPNG = UIImagePNGRepresentation(screenShot);
    NSError *error = nil;
    [screenShotPNG writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"error.png"] options:NSAtomicWrite error:&error];
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass !=nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayMailComposerSheet];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"请先配置您得手机邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark - 邮件发送

- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    // 设置picker的委托方法，完成之后会自动调用成功或失败的方法
    picker.mailComposeDelegate = self;
    // 添加主题
    [picker setSubject:@"Bug反馈"];
    // 添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject:@"ligfufida@gmail.com"];
    [picker setToRecipients:toRecipients];
    //添加截图
    NSData *myData = [NSData dataWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"error.png"]];
    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"error.png"];
    
    NSString *emailBody = @"Bug描述";
    
    [picker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: Mail sending canceled");  // 邮件发送取消
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: Mail saved");  // 邮件保存成功
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: Mail sent");  // 邮件发送成功
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: Mail sending failed");  // 邮件发送失败
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"messageComposeViewController");
}

@end
