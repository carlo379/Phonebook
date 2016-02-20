//
//  AddEditViewController.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/19/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "AddEditViewController.h"
#import "Constants.h"

@interface AddEditViewController ()

// IBOutlet to height layout constraint for Top Bar
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBarHeightConstraint;

@end

@implementation AddEditViewController

#pragma mark - View Controller Lifecylce
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    
    // Modify top bar height according to orientation. This
    // is to behave according to Navigation Bar pattern
    self.topBarHeightConstraint.constant = (self.view.bounds.size.height > self.view.bounds.size.width)? kTopBarPortraitHeight : kTopBarLandscapeHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    
    // Dismiss Modal View Controlle when 'Cancel' button pressed
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    
}


@end
