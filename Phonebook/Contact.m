//
//  Contact.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/21/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+(BOOL)addContactWithRecordDictionary:(NSDictionary *)recordDictionary inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr {
    // Flags
    NSError *saveError;
    
    //Change to 'Record'
    Contact *contact = nil;
    
    contact = [NSEntityDescription insertNewObjectForEntityForName:kContactEntityName inManagedObjectContext:context];
    contact.firstName = [recordDictionary valueForKeyPath:kContactFirstNameAttributeKey];
    contact.lastName = [recordDictionary valueForKeyPath:kContactLastNameAttributeKey];
    contact.phoneNumber = [recordDictionary valueForKeyPath:kContactPhoneNumberAttributeKey];

    // save context after adding record and return result
    return [self saveContext:context error:&saveError];
}

+(BOOL)saveContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr {
    
    // Flags
    BOOL success = YES;         // Return variable
    NSError *saveError = nil;   // Save Changes to Managed Object Context
    
    if([context hasChanges]){
        success = [context save:&saveError];
        if(!success) {
            // Generate Assertion if fails
            NSAssert(NO, @"Error saving context: %@\n%@", [saveError localizedDescription], [saveError userInfo]);
        }
    }
    
    return success;
}

- (BOOL)deleteContactInManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr {
    
    // Flags
    NSError *saveError = nil;   // Save Changes to Managed Object Context
    
    // Delete Contact
    [context deleteObject:self];
    
    // Return 'save' operation results
    return [Contact saveContext:self.managedObjectContext error:&saveError];
}

- (BOOL)deleteContact {
    
    // Call Delete operation on 'self'
    [self.managedObjectContext deleteObject:self];
    
    // Return 'save' operation results
    return [Contact saveContext:self.managedObjectContext error:nil];
}

@end
