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
    [self testMethod];
}

- (void)testMethod
{
    for (int i = 0; i < 100000; i++)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:@"document"];
        
        NSLog(@"%d", isExist);
    }
}

@end
