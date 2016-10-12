//
//  GofBViewController.m
//  GofMediator
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import "GofBViewController.h"

@implementation GofBViewController

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
    
    self.view.backgroundColor = [UIColor greenColor];
}

@end
