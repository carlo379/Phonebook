//
//  BaseTableViewController.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

@class Contact;

@interface BaseTableViewController : UITableViewController

// Method for cell configuration
- (void)configureCell:(UITableViewCell *)cell forContact:(Contact *)contact;

@end
