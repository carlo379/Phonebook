//
//  PhonebookTableViewController.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//
#import "BaseTableViewController.h"

@interface PhonebookTableViewController : BaseTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
