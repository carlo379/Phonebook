//
//  AddEditViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "AddEditViewController.h"
#import "Constants.h"
#import "Contact.h"
#import "HelpMethods.h"

#pragma mark - Constants
// Input Validation
static NSString * const kSpecialCharacters = @"=+_-./\\{}[](),*&^%$#@!~`<>?|;:0123456789'\"";
static NSString * const kEmptyString = @"";
// AlertViewController for Save Error
static NSString * const kAlertTitle = @"Save Error";
static NSString * const kAlertMessage = @"An error ocurred while saving/updating the contact data. Please try again later.";
static NSString * const kActionTitle = @"Dismiss";

#pragma mark - Interface
@interface AddEditViewController ()<UITextFieldDelegate>

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBarHeightConstraint;// IBOutlet to 'height layout constraint' for Top Bar
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;           // Textfield Properties
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;            // Textfield Properties
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;         // Textfield Properties
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;           // Controller Navigation Bar; used to set Title
@property (weak, nonatomic) IBOutlet UILabel *firstNameErrorMessage;            // Property for showing error message
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberErrorMessage;          // Property for showing error message
// Flags
@property (assign) BOOL contactEdited;                                          // Flag when passed Contact was edited

@end

#pragma mark - Implementation
@implementation AddEditViewController

#pragma mark - View Controller Lifecylce
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Check if on Edit Mode
    if(self.isEditable){
        
        // Set View Title
        self.navigationBar.title = @"Edit Contact";
        
        // Update UI with passed Information.
        [self updateInterface];
        
    } else {
        
        // Set View Title
        self.navigationBar.title = @"Add Contact";
        
    }
}

- (void)viewWillLayoutSubviews {
    
    // Modify top bar height according to orientation. This is to behave according to Navigation Bar pattern
    self.topBarHeightConstraint.constant = (self.view.bounds.size.height > self.view.bounds.size.width)? kTopBarPortraitHeight : kTopBarLandscapeHeight;
}

#pragma mark - IBActions
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    
    // Dismiss Modal View Controlle when 'Cancel' button pressed
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    // Flags
    BOOL success = YES;
    NSError *error = nil;
    
    // Validate TextField Inputs
    if([self requirementsCompleted]) {
        
        // Check if editing or adding contact
        if(self.editable){
            
            // Check if contact was edited indeed
            if(self.contactEdited) {
                
                // update passed Contact Object
                [self updatePassedContact];
                
                // Call Method from Contact Model to Save Context
                success = [Contact saveContext:self.managedObjectContext error:&error];
            }
            
        } else {
            
            // Call Method from Contact Model to Add Entry
            success = [Contact addContactWithRecordDictionary:[self dictionaryFromTextFieldsInputs] inManagedObjectContext:self.managedObjectContext error:&error];
        }
        
        if(success){
            
            // Dismiss Modal View Controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            // Allert User an Error occurred and Information was not saved.
            [self showAlert];
            
            // Verify for errors during Fetch; Generate Assertion if fails.
            NSAssert2(success, @"Unhandled error performing fetch at PhonebookTableViewController, line %d: %@", __LINE__, [error localizedDescription]);
            
        }
    }

}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Set Flag to tell passed Contact was edited
    self.contactEdited = YES;
    
    // Clear Error Message if any
    self.phoneNumberErrorMessage.hidden = YES;
    self.firstNameErrorMessage.hidden = YES;
    
    // Sanitize entries based on textfield
    if(textField == self.phoneNumberTextField){
        
        textField.text = [self formatPhoneNumberTextField:textField InRange:range withReplacementString:string];
        
    } else {
        
        textField.text = [self formatNameTextField:textField InRange:range withReplacementString:string];

    }
    
    return NO;
}

#pragma mark - Instance Methods
- (NSDictionary *)dictionaryFromTextFieldsInputs {
    
    // Create NSDictionary from TextFields Input
    NSMutableDictionary *recordDictionary = [[NSMutableDictionary alloc]init];
    [recordDictionary setValue:self.firstNameTextField.text forKey:kContactFirstNameAttributeKey];
    [recordDictionary setValue:self.lastNameTextField.text forKey:kContactLastNameAttributeKey];
    [recordDictionary setValue:self.phoneNumberTextField.text forKey:kContactPhoneNumberAttributeKey];
    
    return recordDictionary;
}

- (void)updateInterface {
    
    // Update Textfields with passed contact
    self.firstNameTextField.text = self.passedContact.firstName;
    self.lastNameTextField.text = self.passedContact.lastName;
    self.phoneNumberTextField.text = self.passedContact.phoneNumber;
}

- (void)updatePassedContact {
    
    // Update passed contact with TextField Information
    [self.passedContact setValue:self.firstNameTextField.text forKey:kContactFirstNameAttributeKey];
    [self.passedContact setValue:self.lastNameTextField.text forKey:kContactLastNameAttributeKey];
    [self.passedContact setValue:self.phoneNumberTextField.text forKey:kContactPhoneNumberAttributeKey];
}

- (void)showAlert {
    
    // Instantiate Help object
    HelpMethods *help = [[HelpMethods alloc]init];
    
    // Call Help method to show Alert Error Message to user
    [help showAlertOnViewController:self withTitle:kAlertTitle andMessage:kAlertMessage andActionTitle:kActionTitle];
}

- (NSString *)formatPhoneNumberTextField:(UITextField *)textField InRange:(NSRange)range withReplacementString:(NSString *)string{
    
    // Remove any non Digital Character from string
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:kEmptyString];
    
    // Verify if number has a Leading #1
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 0 && [decimalString characterAtIndex:0] == '1';
    
    // Return only numbers and do not format: (123456788909876)
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        return decimalString;
    }
    
    NSUInteger index = 0;
    NSMutableString *formattedString = [NSMutableString string];
    
    // Format phone number according to 1 (XXX) XXX-XXXX;
    if (hasLeadingOne) {
        [formattedString appendString:@"1 "];
        index += 1;
    }
    
    if (length - index > 3) {
        NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"(%@) ",areaCode];
        index += 3;
    }
    
    if (length - index > 3) {
        NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"%@-",prefix];
        index += 3;
    }
    
    NSString *remainder = [decimalString substringFromIndex:index];
    [formattedString appendString:remainder];

    return formattedString;
}

- (NSString *)formatNameTextField:(UITextField *)textField InRange:(NSRange)range withReplacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // Remove any of the special characters listed in constant:kSpecialCharacters
    NSCharacterSet *notAllowedChars = [NSCharacterSet characterSetWithCharactersInString:kSpecialCharacters];
    NSString *resultString = [[newString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:kEmptyString];
    
    return resultString;
}

- (BOOL)requirementsCompleted {
    BOOL success = YES;
    
    // Vefify Textfield has text (Required TextField) or show Error message
    if(![self.firstNameTextField hasText]) {
        self.firstNameErrorMessage.hidden = NO;
        success = NO;
    }
    
    // Vefify Textfield has text (Required TextField) or show Error message
    if(![self.phoneNumberTextField hasText]) {
        self.phoneNumberErrorMessage.hidden = NO;
        success = NO;
    }
    
    return success;
}

@end
