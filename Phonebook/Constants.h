//
//  Constants.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//
//  This header is included in 'PrefixHeader.pch'

#ifndef Constants_h
#define Constants_h

/*** Tag Usage convention ****************/
// PhonebookTableView   = 1xxx  (ex: 1001)
// DetailsView          = 2xxx  (ex: 2005)
// AddEditView          = 3xxx  (ex: 3053)
/*****************************************/

// SEGUES
FOUNDATION_EXPORT NSString *const kTableViewToDetailsViewSegue;
FOUNDATION_EXPORT NSString *const kTableViewToAddEditViewSegue
FOUNDATION_EXPORT NSString *const kDetailsViewToAddEditViewSegue

#endif /* Constants_h */
