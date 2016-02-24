//
//  Constants.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//
//  This header is included in 'PrefixHeader.pch'
//
//  Tag Usage convention ***********************/
//  *  PhonebookTableView   = 1xxx  (ex: 1001) *
//  *  DetailsView          = 2xxx  (ex: 2005) *
//  *  AddEditView          = 3xxx  (ex: 3053) *
//  ********************************************/

@import UIKit;

// SEGUES
extern NSString *const kTableViewToDetailsViewSegue;
extern NSString *const kTableViewToAddEditViewSegue;
extern NSString *const kDetailsViewToAddEditViewSegue;

// UI COMPONENT DIMENSIONS
extern const int kTopBarPortraitHeight;
extern const int kTopBarLandscapeHeight;

// Storyboards
extern NSString *const kPhonebookStoryBoard;

// Storyboards View Controllers
extern NSString *const kAddEditViewController;
extern NSString *const kDetailsViewController;
extern NSString *const kPhonebookTableViewController;

// Entities
extern NSString *const kContactEntityName;

// Entities Attributes
extern NSString *const kContactFirstNameAttributeKey;
extern NSString *const kContactLastNameAttributeKey;
extern NSString *const kContactPhoneNumberAttributeKey;

// Cells
extern NSString *const kContactCellIdentifier;
