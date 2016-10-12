//
//  GofDefaultViewController.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofDefaultViewController.h"
#import "GofViewCreateFactory.h"
#import "GofConstant.h"

@interface GofDefaultViewController ()

@property (nonatomic, strong) UILabel *lblInfo;

@end

@implementation GofDefaultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提示";
    
    [self.view addSubview:self.lblInfo];
}

#pragma mark - Getter

- (UILabel *)lblInfo
{
    if (nil == _lblInfo)
    {
        _lblInfo = [GofViewCreateFactory createLabelWithFrame:(CGRect){10, 300, SCREEN_WIDTH - 20, 20} name:@"页面正在建设中，敬请期待" font:[UIFont systemFontOfSize:18] textColor:[UIColor blackColor]];
    }
    return _lblInfo;
}

@end
