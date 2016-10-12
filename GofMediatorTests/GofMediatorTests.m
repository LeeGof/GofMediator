//
//  GofMediatorTests.m
//  GofMediatorTests
//
//  Created by LeeGof on 16/9/6.
//  Copyright © 2016年 GofLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GofMediator.h"

@interface GofMediatorTests : XCTestCase

@end

@implementation GofMediatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [[GofMediator sharedInstance] performRemoteActionWithUrl:[NSURL URLWithString:@"Gof://targetA/actionB?id=1234&name=LeeGof"]];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
