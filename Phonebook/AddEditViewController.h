//
//  AddEditViewController.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

@class Contact;

@interface AddEditViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (assign, getter=isEditable) BOOL editable;    // Flag when controller is in editing mode
@property (nonatomic, strong) Contact *passedContact;   // Property to pass Contact Object for editing

@end
