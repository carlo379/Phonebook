//
//  TableViewCellConfigurationTests.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/23/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

#pragma mark - Interface
@interface TableViewCellConfigurationTests : XCTestCase

#pragma mark - Properties
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

#pragma mark - Implementation
@implementation TableViewCellConfigurationTests

#pragma mark - Setup Method
- (void)setUp {
    [super setUp];

    self.appDelegate = [[UIApplication sharedApplication] delegate];
}

#pragma mark - Tests
/* testAppDelegate verifies AppDelegate is instantiated and available.
 * The test has one part:
 * 1. Check AppDelegate is not Nil
 */
- (void) testAppDelegate {
    XCTAssertNotNil(self.appDelegate, @"Cannot find the application delegate");
}

@end
