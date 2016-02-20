//
//  Constants.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//
//
//
//  Tag Usage convention ***********************/
//  *  PhonebookTableView   = 1xxx  (ex: 1001) *
//  *  DetailsView          = 2xxx  (ex: 2005) *
//  *  AddEditView          = 3xxx  (ex: 3053) *
//  ********************************************/

#import "Constants.h"




// SEGUES
NSString *const kTableViewToDetailsViewSegue = @"TableViewToDetailsViewSegue";
NSString *const kTableViewToAddEditViewSegue = @"TableViewToAddEditViewSegue";
NSString *const kDetailsViewToAddEditViewSegue = @"DetailsViewToAddEditViewSegue";

// CELLS
NSString *const kPhoneBookEntryCell = @"PhoneBookEntryCell";

// UI COMPONENT DIMENSIONS
const int kTopBarPortraitHeight = 64;
const int kTopBarLandscapeHeight = 44;
