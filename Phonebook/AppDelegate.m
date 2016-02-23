//
//  AppDelegate.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "AppDelegate.h"
#import "PhonebookTableViewController.h"
#import "Contact.h"

// String used to identify the SQLite Store file name
static NSString * const kSQLiteStoreFileName = @"Phonebook.sqlite";

@interface AppDelegate ()

// Properties for the Core Data stack.
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSString *persistentStorePath;

@end

@implementation AppDelegate

#pragma mark - App State Change Methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Get initial View Controller on the navigation stack
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    PhonebookTableViewController *phonebookTableViewController = (PhonebookTableViewController *)navController.visibleViewController;
    
    // Set Initial View Controller managed object context
    phonebookTableViewController.managedObjectContext = self.managedObjectContext;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Saves changes in the application's managed object context before the application become inactive.
    [Contact saveContext:self.managedObjectContext error:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Saves changes in the application's managed object context when entering background.
    [Contact saveContext:self.managedObjectContext error:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Saves changes in the application's managed object context before the application terminates.
    [Contact saveContext:self.managedObjectContext error:nil];
}

#pragma mark - Core Data stack (Setter and/or Getter methods)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator == nil) {
        
        // Get store URL
        NSURL *storeUrl = [NSURL fileURLWithPath:self.persistentStorePath];
        
        // Initialize Persistent Store Coordinator
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
        
        // Add PersistentStore to PersistentStore Coordinator and Check result; Generate Assertion if fails.
        NSError *error = nil;
        NSPersistentStore *persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
        NSAssert3(persistentStore != nil, @"Unhandled error adding persistent store in %s at line %d: %@", __FUNCTION__, __LINE__, [error localizedDescription]);
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext == nil) {
        
        // Initialize Managed Object Context
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        // Add the Persistent Store Cordinator to the Managed Object Context
        (self.managedObjectContext).persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSString *)persistentStorePath {
    
    if (_persistentStorePath == nil) {
        
        // Get Persistent Store Path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths.lastObject;
        _persistentStorePath = [documentsDirectory stringByAppendingPathComponent:kSQLiteStoreFileName];
    }
    return _persistentStorePath;
}

@end
