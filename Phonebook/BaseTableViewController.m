//
//  BaseTableViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Contact.h"

#pragma mark - Constants
static NSString *const kTableCellNibName = @"TableCell";

#pragma mark - Implementation
@implementation BaseTableViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kContactCellIdentifier];
}

#pragma mark - Instance Methods
- (void)configureCell:(UITableViewCell *)cell forContact:(Contact *)contact {
    
    // Populate cell properties with values from Phonebook contact
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    cell.detailTextLabel.text = contact.phoneNumber;
    
}

@end
