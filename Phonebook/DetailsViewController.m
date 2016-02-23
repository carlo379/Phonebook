//
//  DetailsViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "DetailsViewController.h"
#import "AddEditViewController.h"
#import "PhonebookTableViewController.h"
#import "Contact.h" 

#pragma mark - Interface
@interface DetailsViewController ()

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UILabel *firstLastNameLabel;   //
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;     // Property for modifying Display Labels

@end

#pragma mark - Implementation
@implementation DetailsViewController

#pragma mark - View Controller Lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Update UI with passed Information.
    [self updateInterface];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Segue to Add / Edit ViewController from Details ViewController
    if ([segue.identifier isEqualToString: kDetailsViewToAddEditViewSegue]) {
        
        // Set properties of destination view controller
        AddEditViewController *addEditViewController = (AddEditViewController *) [segue destinationViewController];
        addEditViewController.managedObjectContext = self.managedObjectContext; // Set Managed Object Context to property
        addEditViewController.passedContact = self.passedContact;               // Set the contact to edit in property
        addEditViewController.editable = YES;                                   // Flag that is editing contact

    }
}

#pragma mark - Instance Method
- (void)updateInterface {
    
    // Update View Labels with passed contact information
    self.firstLastNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.passedContact.firstName, self.passedContact.lastName];
    self.phoneNumberLabel.text = self.passedContact.phoneNumber;
}

@end
