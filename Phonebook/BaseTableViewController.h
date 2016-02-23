//
//  BaseTableViewController.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

@class Contact;

@interface BaseTableViewController : UITableViewController

/*!
 * @brief
 *      Configure UITableViewCell with model passed to the method.
 * @discussion
 *      This Instance Method configures a UITableViewCell of style 'Right Detail' passed with instance of a Contact
 *      object.  From the Contact Model, First Name and Last Name are conbined into the cell 'textLabel' property
 *      and 'phoneNumber' is set to 'detailTextLabel'.
 * @param cell
 *      'UITableViewCell' of style 'Right Detail'.
 * @param contact
 *      'NSManagedObject' of class 'Contact'.
 * @return
 *      'void' - no return value
 */
- (void)configureCell:(UITableViewCell *)cell forContact:(Contact *)contact;

@end
