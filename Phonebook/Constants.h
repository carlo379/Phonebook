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

#import <UIKit/UIKit.h>

#ifndef Constants_h
#define Constants_h

// SEGUES
extern NSString *const kTableViewToDetailsViewSegue;
extern NSString *const kTableViewToAddEditViewSegue;
extern NSString *const kDetailsViewToAddEditViewSegue;

// CELLS
extern NSString *const kPhoneBookEntryCell;

// UI COMPONENT DIMENSIONS
extern const int kTopBarPortraitHeight;
extern const int kTopBarLandscapeHeight;

// Storyboards
extern NSString *const kPhonebookStoryBoard;

// Storyboards View Controllers
extern NSString *const kAddEditViewController;

#endif /* Constants_h */
