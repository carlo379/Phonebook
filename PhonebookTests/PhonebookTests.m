//
//  PhonebookTests.m
//  PhonebookTests
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

// Test-subject headers.
#import "AppDelegate.h"
#import "AddEditViewController.h"

@interface PhonebookTests : XCTestCase {
    AppDelegate             *app_delegate;
    //AddEditViewController   *addEditViewController;
}
@end

@implementation PhonebookTests

#pragma mark - Test SetUp & TearDown
- (void)setUp {
    [super setUp];
    app_delegate            = [[UIApplication sharedApplication] delegate];
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kPhonebookStoryBoard bundle:nil];
    //addEditViewController   = [storyboard instantiateViewControllerWithIdentifier:kAddEditViewController];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Tests

/* testAppDelegate verifies AppDelegate is instantiated and available.
 * The test has one part:
 * 1. Check AppDelegate is not Nil
 */
- (void) testAppDelegate {
    XCTAssertNotNil(app_delegate, @"Cannot find the application delegate");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    

}

#pragma mark - Performance Tests

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
