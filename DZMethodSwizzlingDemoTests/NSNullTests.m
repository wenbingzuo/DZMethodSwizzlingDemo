//
//  NSNullTests.m
//  DZMethodSwizzlingDemo
//
//  Created by Wenbing Zuo on 4/17/17.
//  Copyright © 2017 Wenbing Zuo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSNullTests : XCTestCase

@end

@implementation NSNullTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testNSNull {
    NSDictionary *dic = @{@"avatar":[NSNull null]};
    id avatar = dic[@"avatar"];

    XCTAssertTrue([avatar integerValue] == 0); // 数字
    XCTAssertTrue([avatar length] == 0); // 字符串
    XCTAssertTrue([avatar count] == 0); // 数组
    XCTAssertTrue([avatar allKeys].count == 0); // 字典
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
