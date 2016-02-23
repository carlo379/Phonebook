//
//  Contact+CoreDataProperties.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/21/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;

@end

NS_ASSUME_NONNULL_END
