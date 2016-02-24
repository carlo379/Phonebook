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
#import "PhonebookTableViewController.h"

#pragma mark - Contacts
// Contact Attributes
NSString * const kTestFirstName = @"John";
NSString * const kTestLastName = @"Doe";
NSString * const kTestPhoneNumber = @"1 (555) 555-5555";
// Modified Contact Attributes
NSString * const kTestModifiedFirstName = @"Jane";
NSString * const kTestModifiedLastName = @"Roe";
NSString * const kTestModifiedPhoneNumber = @"1 (666) 666-6666";

#pragma mark - Interface
@interface ContactTests : XCTestCase

#pragma mark - Properties
@property (nonatomic, strong) PhonebookTableViewController *phonebookTableViewController;
@property (nonatomic, strong) UITableViewCell *configuredCell;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSMutableDictionary *recordDictionary;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) Contact *contact;

@end

#pragma mark - Implementation
@implementation ContactTests

#pragma mark - Setup method
/* setUp executes methods in preparation for the Unit tests
 * The test has eight parts:
 * 1. Creates and NSDictionary with test information; checks for Not Nil.
 * 2. Creates a NSPersistentStoreCoordinator and adds to it an In-Memory Store. checks for success adding store.
 * 3. Initialize and NSManagedObjectContext and adds PersistentStoreCoordinator to it; checks for Not Nil.
 * 4. Adds a Contact object to the In-Memory Store.
 * 5. Creates a Fetch Request; checks for Not Nil.
 * 6. Get an Entity Description from In-Memory Store; checks for Not Nil.
 * 7. Fetch Object from In-Memory Store; checks for Not Nil and no Errors.
 * 8. Add Fetched Object to test method property (contact).
 */
- (void)setUp {
    [super setUp];
    
    NSLog(@"%@ setUp", self.name);
    
    // Create NSDictionary with text data
    self.recordDictionary = [[NSMutableDictionary alloc]init];
    [self.recordDictionary setValue:kTestFirstName forKey:kContactFirstNameAttributeKey];
    [self.recordDictionary setValue:kTestLastName forKey:kContactLastNameAttributeKey];
    [self.recordDictionary setValue:kTestPhoneNumber forKey:kContactPhoneNumberAttributeKey];
    XCTAssertNotNil(self.recordDictionary, @"Cannot create NSDictionary instance");
    
    /***** Build a Core Data stack in-memory for testing *****
     *********************************************************/
    
    // Initialize Persistent Store Coordinator
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    XCTAssertTrue([persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    
    // Initialize Managed Object Context
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    XCTAssertNotNil(self.managedObjectContext, @"Cannot create NSManagedObjectContext instance");
    
    //Add Object to In-Memory Store
    [self testAddContact];
    
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
/* testAddContact attempts to Add a contact to the In-Memory Store, from an NSDictionary object
 * The test has two parts:
 * 1. Check that saveContext:error returns 'True' after saving context.
 * 2. Check that the Error object is nil after saving context.
 */
- (void)testAddContact {
    
    // Add new Contact from NSDictionary and test return value and error object
    NSError *error;
    XCTAssertTrue([Contact addContactWithRecordDictionary:self.recordDictionary inManagedObjectContext:self.managedObjectContext error:&error], @"Cannot Add Contact to In-Memory Store");
    XCTAssertNil(error, @"Error must be nil");
}

/* testDeleteContact attempts to delete an In-Memory Store Object and check for success.
 * The test has one part:
 * 1. Check that saveContext:error returns 'True' after saving context.
 */
- (void)testDeleteContact {
    
    // Delete Object In-Memory Store and verify success
    XCTAssertTrue([self.contact deleteContact], @"Cannot Delete Contact from In-Memory Store");
}

/* testSaveContext attempts to save the provided context after an object was modified.
 * The test has two parts:
 * 1. Check that saveContext:error returns 'True' after saving context.
 * 2. Check that the Error object is nil after saving context.
 */
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

/* testConfigureCell verifies that BaseTableViewController public method (configureCell:ForContact) cofigures an
 * UITableViewCell correctly with the data of a passed Contact.
 * The test has one part:
 * 1. Check that passed cell and constructed cell objects are Equal.
 */
- (void) testConfigureCell {
    
    // Initialize a UITableViewCell and configures it with test information.
    UITableViewCell *expectedCell = [expectedCell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    expectedCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", kTestFirstName, kTestLastName];
    expectedCell.detailTextLabel.text = kTestPhoneNumber;
    
    // Check UITableViewCell was configured correctly and is equal to expected object.
    [self.phonebookTableViewController configureCell:self.configuredCell forContact:self.contact];
    XCTAssertEqualObjects(expectedCell, self.configuredCell, @"The configured cell did not match the expected Cell");
}

@end
