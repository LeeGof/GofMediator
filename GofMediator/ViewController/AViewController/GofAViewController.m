//
//  GofAViewController.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofAViewController.h"
#import "GofViewCreateFactory.h"
#import "GofConstant.h"
#import "GofMediator+GofBModule.h"
#import "GofMediator+GofCModule.h"

@interface GofAViewController ()

@property (nonatomic, strong) UIButton *btnModuleB;
@property (nonatomic, strong) UIButton *btnModuleC;
@property (nonatomic, strong) UIButton *btnAlert;

@end

@implementation GofAViewController

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.title = title;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btnModuleB];
    [self.view addSubview:self.btnModuleC];
    [self.view addSubview:self.btnAlert];
}

#pragma mark - Event

- (void)btnClick:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 0:
        {
//            Class cls = NSClassFromString(@"GofTargetBModule");
//            UIViewController *reviewVC = [cls performSelector:NSSelectorFromString(@"actionBViewCtrlWithParam:") withObject:@{@"title":@"模块B"}];
//            [self.navigationController pushViewController:reviewVC animated:YES];
            
            UIViewController *vc = [[GofMediator sharedInstance] mediatorBViewController];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            UIViewController *vc = [[GofMediator sharedInstance] mediatorCViewController];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            [[GofMediator sharedInstance] showAlertWithWithMessage:@"Hello World" cancelAction:^(NSDictionary *info) {
                NSLog(@"取消");
            } confirmAction:^(NSDictionary *info) {
                NSLog(@"确定");
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Getter

- (UIButton *)btnModuleB
{
    if (nil == _btnModuleB)
    {
        _btnModuleB = [GofViewCreateFactory createCustomButtonWithFrame:(CGRect){10, 100, SCREEN_WIDTH - 20, 40} name:@"ModuleB" delegate:self selector:@selector(btnClick:) tag:0];
        _btnModuleB.backgroundColor = kEssentialColor;
    }
    return _btnModuleB;
}

- (UIButton *)btnModuleC
{
    if (nil == _btnModuleC)
    {
        _btnModuleC = [GofViewCreateFactory createCustomButtonWithFrame:(CGRect){10, 160, SCREEN_WIDTH - 20, 40} name:@"ModuleC" delegate:self selector:@selector(btnClick:) tag:1];
        _btnModuleC.backgroundColor = kEssentialColor;
    }
    return _btnModuleC;
}

- (UIButton *)btnAlert
{
    if (nil == _btnAlert)
    {
        _btnAlert = [GofViewCreateFactory createCustomButtonWithFrame:(CGRect){10, 220, SCREEN_WIDTH - 20, 40} name:@"Alert" delegate:self selector:@selector(btnClick:) tag:2];
        _btnAlert.backgroundColor = kEssentialColor;
    }
    return _btnAlert;
}

@end
