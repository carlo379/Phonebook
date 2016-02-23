//
//  Contact.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/21/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

/*!
 * @class Contact
 * This class implements Contact objects based on Core Data Contact Entity
 * Entity Attributes or Properties include 'firstName', 'lastName', 'phoneNumber'
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSManagedObject

#pragma mark - Class Methods
/*!
 * @brief
 *      Creates new Phonebook object and add entry in persistent store.
 * @discussion
 *      This Class Method accepts NSStrings for First Name, Last Name and Phone Number.  First Name and Last Name entries can be repeated
 *      in database, but Phone Number must be unique.
 * @param recordDictionary
 *      'NSDictionary' with data of Contact to add. Must Include keys for 'firstName', 'lastName' and 'phoneNumber'.
 * @param context
 *      'NSManagedObjectContext' of the application managing the objects of the data store.
 * @param error
 *      Reference to an NSError pointer; pass error back by Reference
 *      Before you call this method, you’ll need to create a suitable pointer so that you can pass its address.
 * @code
 *      NSError *anyError;
 * @endcode
 * @return
 *      boolean value YES or NO.
 *      YES - Success adding new Entry.
 *      NO - Fail adding new Entry; Check error reference.
 * @remark
 *      This method calls Class Method 'saveContext:context:error' to save context after addition.
 */
+ (BOOL)addContactWithRecordDictionary:(NSDictionary *)recordDictionary inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr;

/*!
 * @brief
 *      Perform 'save' operation on passed Context.
 * @discussion
 *      This Class Method performs a 'save' operation to commit unsaved changes to registered objects; this is performed
 *      on the passed 'NSManagedObjectContext'.
 * @param context
 *      'NSManagedObjectContext' of the application managing the objects of the data store.
 * @param error
 *      Reference to an NSError pointer; pass error back by Reference
 *      Before you call this method, you’ll need to create a suitable pointer so that you can pass its address.
 * @code
 *      NSError *anyError;
 * @endcode
 * @return
 *      boolean value YES or NO.
 *      YES - Success commiting unsaved changes.
 *      NO - Fail commiting unsaved changes; Check error reference.
 * @remark
 *      This method calls 'hasChanges' before attempting to perform 'save' operation. No opeartion is done if there
 *      are no changes in 'Context'.
 */
+ (BOOL)saveContext:(NSManagedObjectContext *)context error:(NSError **)errorPtr;

#pragma mark - Instance Methods
/*!
 * @brief
 *      Perform 'deleteObject' operation on caller NSManagedObjectContext.
 * @discussion
 *      This Class Method performs a 'deleteObject' operation to the object calling the method; with the caller 'NSManagedObjectContext'.
 * @return
 *      boolean value YES or NO.
 *      YES - Success commiting unsaved changes.
 *      NO - Fail commiting unsaved changes; Check error reference.
 * @remark
 *      This method calls Class Method 'saveContext:context:error' to save context after deletion.
 */
- (BOOL)deleteContact;

@end

NS_ASSUME_NONNULL_END

#import "Contact+CoreDataProperties.h"
