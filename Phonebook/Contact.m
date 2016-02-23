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
    
    //Change to 'Record'
    Contact *contact = nil;
    
    contact = [NSEntityDescription insertNewObjectForEntityForName:kContactEntityName inManagedObjectContext:context];
    contact.firstName = [recordDictionary valueForKeyPath:kContactFirstNameAttributeKey];
    contact.lastName = [recordDictionary valueForKeyPath:kContactLastNameAttributeKey];
    contact.phoneNumber = [recordDictionary valueForKeyPath:kContactPhoneNumberAttributeKey];

    NSError *saveError;
    // save context after adding record and return result
    BOOL success = [self saveContext:context error:&saveError];
    
    // Verify if error
    if (!success) {
        
        // Check that pointer was passed
        if (errorPtr) {
            
            // Pass error to pointer of NSError
            *errorPtr = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSUnderlyingErrorKey: saveError}];
        }
    }
    
    return success;
}

+(BOOL)saveContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr {
    
    // Flags
    BOOL success = YES;         // Return variable
    
    if([context hasChanges]){
        
        // Save Changes to Managed Object Context
        NSError *saveError = nil;
        success = [context save:&saveError];
        
        // Verify if error
        if(!success) {
            
            // Generate Assertion for error
            NSAssert(NO, @"Error saving context: %@\n%@", [saveError localizedDescription], [saveError userInfo]);
            
            // Check that pointer was passed
            if (errorPtr) {
                
                // Pass error to pointer of NSError
                *errorPtr = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileWriteUnknownError userInfo:@{NSUnderlyingErrorKey: saveError}];
            }
        }
    }
    
    return success;
}

- (BOOL)deleteContact {
    
    // Call Delete operation on 'self'
    [self.managedObjectContext deleteObject:self];
    
    // Return 'save' operation results
    return [Contact saveContext:self.managedObjectContext error:nil];
}

@end
