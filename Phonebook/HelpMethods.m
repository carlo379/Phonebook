//
//  HelpMethods.m
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

#import "HelpMethods.h"

#pragma mark - Constants
static NSString * const kErrorMessage = @"Error Updating Context";

#pragma mark - Implementation
@implementation HelpMethods

#pragma mark - Instance Methods
-(void)showAlertOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message andActionTitle:(NSString *)actionTitle {
    
    // Create AlertController
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Create Action for AlertController
    UIAlertAction *dissmisAction = [UIAlertAction actionWithTitle:actionTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *actionPerformed){
                                                              NSLog(kErrorMessage);
                                                          }];
    // Add Action to AlertController
    [alertController addAction:dissmisAction];
    
    // Present Alert Controller
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
