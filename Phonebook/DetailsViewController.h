//
//  DetailsViewController.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

@class Contact;

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Contact *passedContact; // Property to pass Contact Object for Display

@end
