//
//  NewTest.m
//  NewTest
//
//  Created by Prakshi Bector on 25/2/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface NewTest : XCTestCase
@property (nonatomic) ViewController *vcTest;
@end

@implementation NewTest

- (void)setUp {
    [super setUp];
    
    self.vcTest=[[ViewController alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    [_vcTest callJsonData];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [_vcTest callJsonData];

        // Put the code you want to measure the time of here.
    }];
}

@end
