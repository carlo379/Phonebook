//
//  Constants.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.

#import "Constants.h"

// SEGUES
NSString *const kTableViewToDetailsViewSegue = @"tableViewToDetailsViewSegue";
NSString *const kTableViewToAddEditViewSegue = @"tableViewToAddEditViewSegue";
NSString *const kDetailsViewToAddEditViewSegue = @"detailsViewToAddEditViewSegue";

// UI COMPONENT DIMENSIONS
const int kTopBarPortraitHeight = 64;
const int kTopBarLandscapeHeight = 44;

// Storyboards
NSString *const kPhonebookStoryBoard = @"Phonebook";

// Storyboards View Controllers
NSString *const kAddEditViewController = @"addEditViewController";
NSString *const kDetailsViewController = @"detailsViewController";
NSString *const kPhonebookTableViewController = @"phonebookTableViewController";

// Entities
NSString * const kContactEntityName  = @"Contact";

// Entities Attributes
NSString * const kContactFirstNameAttributeKey = @"firstName";
NSString * const kContactLastNameAttributeKey  = @"lastName";
NSString * const kContactPhoneNumberAttributeKey  = @"phoneNumber";

// Cells
NSString * const kContactCellIdentifier = @"contactCellIdentifier";