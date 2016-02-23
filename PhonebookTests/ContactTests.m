//
//  ContactTests.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/23/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Contact.h"
#import "Constants.h"

#pragma mark - Constants
// Contact Attributes
static NSString * const kTestFirstName = @"John";
static NSString * const kTestLastName = @"Doe";
static NSString * const kTestPhoneNumber = @"1 (555) 555-5555";
// Modified Contact Attributes
static NSString * const kTestModifiedFirstName = @"Jane";
static NSString * const kTestModifiedLastName = @"Roe";
static NSString * const kTestModifiedPhoneNumber = @"1 (666) 666-6666";

#pragma mark - Interface
@interface ContactTests : XCTestCase

#pragma mark - Properties
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableDictionary *recordDictionary;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) Contact *contact;

@end

#pragma mark - Implementation
@implementation ContactTests

#pragma mark - Setup method
- (void)setUp {
    [super setUp];
    // Log Setup started
    NSLog(@"%@ setUp", self.name);
    
    // Create NSDictionary with text data
    self.recordDictionary = [[NSMutableDictionary alloc]init];
    [self.recordDictionary setValue:kTestFirstName forKey:kContactFirstNameAttributeKey];
    [self.recordDictionary setValue:kTestLastName forKey:kContactLastNameAttributeKey];
    [self.recordDictionary setValue:kTestPhoneNumber forKey:kContactPhoneNumberAttributeKey];
    XCTAssertNotNil(self.recordDictionary, @"Cannot create NSDictionary instance");
    
    /***** Build a Core Data stack in-memory for testing *****/
    
    // Initialize Persistent Store Coordinator
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    XCTAssertTrue([persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    
    // Initialize Managed Object Context
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    XCTAssertNotNil(self.managedObjectContext, @"Cannot create NSManagedObjectContext instance");
    
    /***** Add Object to In-Memory Store *****/
    
    [self testAddContact];
    
    /***** Prepare and Fetch from In-Memory Store *****/
    
    // Initialize Fetch Request
    self.fetchRequest = [[NSFetchRequest alloc] init];
    XCTAssertNotNil(self.fetchRequest, @"Cannot create NSFetchRequest instance");
    
    // Get Entity Description from Store and add to Fetch Request
    NSEntityDescription *entity = [NSEntityDescription entityForName:kContactEntityName inManagedObjectContext:self.managedObjectContext];
    [self.fetchRequest setEntity:entity];
    XCTAssertNotNil(entity, @"Cannot get Entity In-Memory Store");
    
    // Fetch objects from In-memory store
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:self.fetchRequest error:&error];
    XCTAssertNotNil(fetchedObjects, @"Cannot get Objects from In-Memory Store");
    XCTAssertNil(error, @"Error must be nil");
    
    // Get Contact from FetchObjects Array at index 0
    self.contact = (Contact *)[fetchedObjects objectAtIndex:0];
}

#pragma mark - Tests
- (void)testAddContact {
    
    // Add new Contact from NSDictionary and test return value and error object
    NSError *error;
    XCTAssertTrue([Contact addContactWithRecordDictionary:self.recordDictionary inManagedObjectContext:self.managedObjectContext error:&error], @"Cannot Add Contact to In-Memory Store");
    XCTAssertNil(error, @"Error must be nil");
}

- (void)testDeleteContact {
    
    // Delete Object In-Memory Store
    XCTAssertTrue([self.contact deleteContact], @"Cannot Delete Contact from In-Memory Store");
}

- (void)testSaveContext {
    
    // Modify Object and attempt to save context
    self.contact.firstName = kTestModifiedFirstName;
    self.contact.lastName = kTestModifiedLastName;
    self.contact.phoneNumber = kTestModifiedPhoneNumber;
    
    // Save context due to changes in Object In-Memory Store
    NSError *error;
    XCTAssertTrue([Contact saveContext:self.managedObjectContext error:&error], @"Cannot Delete Contact from In-Memory Store");
    XCTAssertNil(error, @"Error must be nil");
}

@end
