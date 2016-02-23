//
//  PhonebookTableViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "PhonebookTableViewController.h"
#import "AddEditViewController.h"
#import "DetailsViewController.h"
#import "ResultsTableViewController.h"
#import "Contact.h"
#import "HelpMethods.h"

#pragma mark - Constants
// AlertViewController for Delete Error
static NSString * const kAlertTitle = @"Delete Error";
static NSString * const kAlertMessage = @"An error ocurred while deleting the contact data. Please try again later.";
static NSString * const kActionTitle = @"Dismiss";

#pragma mark - Interface
@interface PhonebookTableViewController ()<NSFetchedResultsControllerDelegate,UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

#pragma mark Properties
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UISearchController *searchController;

// Secondary search results table view
@property (nonatomic, strong) ResultsTableViewController *resultsTableViewController;

// Flags for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

// Property to story currently selected event
@property (strong, nonatomic) Contact *selectedContact;

@end

#pragma mark - Implementation
@implementation PhonebookTableViewController

#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the left button for "Edit"
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Set FetchResultsController Delegate
    self.fetchedResultsController.delegate = self;
    
    // Initialize ResultTableViewController and assign to property
    _resultsTableViewController = [[ResultsTableViewController alloc] init];
    
    // Initialize UISearchController with ResultsViewController and set Delegates (self) for controller and Bar
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableViewController];
    self.searchController.searchResultsUpdater = self;  //
    self.searchController.delegate = self;              // Set Delegates
    self.searchController.searchBar.delegate = self;    //
    [self.searchController.searchBar sizeToFit];                //
    self.searchController.dimsBackgroundDuringPresentation = NO;// Configure controller
    
    // Set searchbar as tableHeaderView
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Set Self as delegate for filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableViewController.tableView.delegate = self;
    self.definesPresentationContext = YES;
    
    // Fetch Phonebook data from data store
    [self fetch];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Ensure the Searchcontroller State is preserved from view changes
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - Getter / Setter methods
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController == nil) {
        
        // Initialize Fetch request object
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        // Add entity to fetch request object
        fetchRequest.entity = [NSEntityDescription entityForName:kContactEntityName inManagedObjectContext:self.managedObjectContext];
        
        // Create a sort descriptors for attributes of the entity that want to sort for
        NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:kContactFirstNameAttributeKey ascending:YES];
        NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:kContactLastNameAttributeKey ascending:YES];
        
        // Create Sort Descriptor array with previous sort descriptors and add to fetchrequest
        NSArray *sortDescriptors = @[firstNameDescriptor, lastNameDescriptor];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Initialize Fetch Results Controller with fetch reques and managed object context
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    }
    return _fetchedResultsController;
}

#pragma mark - Instance Methods
- (void)fetch {
    
    // Perform Fetch
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    
    // Verify for erros during Fetch; Generate Assertion if fails.
    NSAssert2(success, @"Unhandled error performing fetch at PhonebookTableViewController, line %d: %@", __LINE__, [error localizedDescription]);
    
    // Reload TableView after fetch
    [self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // Create phonebook object with fetched result controller object
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure Cell at indexpath using inherited method from BaseTableViewController
    [self configureCell:cell forContact:contact];
}

- (void)showAlert {
    
    // Instantiate Help object
    HelpMethods *help = [[HelpMethods alloc]init];
    
    // Call Help method to show Alert Error Message to user
    [help showAlertOnViewController:self withTitle:kAlertTitle andMessage:kAlertMessage andActionTitle:kActionTitle];
}

#pragma mark - TableViewDataSource Protocol Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return quantity of sections fetched
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Assign Section info to a Generic object that conform to the NSFetchedResultsSectionInfo protocol
    id <NSFetchedResultsSectionInfo> sectionInfo = (self.fetchedResultsController.sections)[section];
    
    // Returns quantity of objects in current section
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kContactCellIdentifier forIndexPath:indexPath];

    // Call Method to Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Get Contact to delete from Data Store
        Contact *contactToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // Remove the row from data Store by calling Model Instance Method
        if(![contactToDelete deleteContact])
            [self showAlert];
    }
    
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Verify if TableView data was filterd to decide from where to the Contact was selected
    self.selectedContact = (tableView == self.tableView) ?
    [self.fetchedResultsController objectAtIndexPath:indexPath] : self.resultsTableViewController.filteredProducts[indexPath.row];
    
    // Perform Segue: from TableViewController to DetailsViewController
    [self performSegueWithIdentifier:kTableViewToDetailsViewSegue sender:self];
}

#pragma mark - NSFetchedResultsControllerDelegate Methods
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    // Notify when an Object changed in the Fetch Results Controller and perform corresponding action to change type
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
    }
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating Protocol Methods
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [NSMutableArray arrayWithArray:[self.fetchedResultsController fetchedObjects]];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstName contains[c] %@",searchText];
    searchResults = [[searchResults filteredArrayUsingPredicate:predicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    ResultsTableViewController *tableController = (ResultsTableViewController *)self.searchController.searchResultsController;
    tableController.filteredProducts = searchResults;
    [tableController.tableView reloadData];
}

#pragma mark - Navigation (Segue) Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Segue to Edit Shoe for Container View
    if ([segue.identifier isEqualToString: kTableViewToAddEditViewSegue]) {
        
        AddEditViewController *addEditViewController = (AddEditViewController *) [segue destinationViewController];
        addEditViewController.managedObjectContext = self.managedObjectContext;
        
    } else if ([segue.identifier isEqualToString:kTableViewToDetailsViewSegue]) {
        
        // Pass the selected book to the new view controller.
        DetailsViewController *detailsViewController = (DetailsViewController *)[segue destinationViewController];
        detailsViewController.managedObjectContext = self.managedObjectContext;
        detailsViewController.passedContact = self.selectedContact;
    }
}

@end
