//
//  HelpMethods.h
//  Phonebook
//
//  Created by Carlos Martinez on 2/22/16.
//  Copyright © 2016 Carlos Martinez. All rights reserved.
//

@interface HelpMethods : NSObject

/*!
 * @brief
 *      Show Alert on passed ViewController.
 * @discussion
 *      This Instance Method shows an Alert View on the passed ViewController and with text passed by the caller on
 *      parameters 'title', 'message' and 'actionTitle.
 * @param viewController
 *      'UIViewController' were the Alert is going to be shown.
 * @param title
 *      'NSString' representing the Alert title text.
 * @param message
 *      'NSString' representing the Alert message body text.
 * @param actionTitle
 *      'NSString' representing the Alert Button text. Tells the user what action to expect from pressing the button
 * @return
 *      'void' - no return value
 */
-(void)showAlertOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message andActionTitle:(NSString *)actionTitle;

@end
