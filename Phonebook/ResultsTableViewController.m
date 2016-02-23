//
//  ResultsTableViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "Contact.h"

#pragma mark - Interface
@implementation ResultsTableViewController

#pragma mark - TableViewDataSource Protocol Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of filtered products
    return self.filteredProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get Cell from Queue
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kContactCellIdentifier];
    
    // Get contact at indexpath
    Contact *contact = self.filteredProducts[indexPath.row];
    
    // Configure Cell at indexpath using inherited method from BaseTableViewController
    [self configureCell:cell forContact:contact];
    
    return cell;
}

@end