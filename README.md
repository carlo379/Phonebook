# Phonebook
Simple Phonebook application for the iOS family of devices (Universal Application)
Phonebook Software Architecture Design

Purpose and Scope
	
	This Software Architecture Design (SAD) is created to document the architecture of a Phonebook application for the iOS family of devices designed by Apple Inc.  It will explain the design choices made to for the implementation of the phonebook application.

Expected Outcome

	Complete design and implementation of a phonebook application, which will be targeted for iPhone and iPad devices (Universal app). 

Selected Technologies

Platform: iOS Universal Application (iPhone and iPad)
Target OS: iOS - Version 9.2
Language: Objective-C
Repository: GIT / Github
Testing: XCTest (Xcode Testing Framework) and OS X Server
IDE: Xcode - Version 7.2.1
Application Requirements
Each phonebook entry must have at least 2 fields: name and phone number.
The phonebook functionalities must include: adding an entry, removing an entry, listing all entries, searching a specific entry by name.
The user interface can be graphical or command line based

Application Architecture
For this application I’m using the Model-View-Controller (MVC) design pattern because of its extensive use in the Cocoa framework and because it provides clear roles for each of the objects in the application.

Image from https://developer.apple.com


Model: For models objects I decided to use the Core Data framework which facilitates the management and persistence of the model objects.  It consists of the following objects: External persistent store, Persistent Object Store, Persistent Store Coordinator, Managed Object Model and Managed Object Context.


Image from https://developer.apple.com

View: For view objects I’m using the Interface Builder (component of Xcode), Storyboards and XIBs to graphically layout views in the User Interface (UI).  With Storyboards I’m dividing the UI in scenes, transitions (segues) and controls.  XIBs are used to layout some individual components which can be reused by several views.

Image from https://developer.apple.com
Controller: For controllers I will use UIViewControllers and UITableViewController to manage the different portions of the user interface; A UINavigationViewControllers will be used to manage the hierarchy of views when going from the root view controller (UITableViewController) to a details view controller (UIViewController).  


Image from https://developer.apple.com























System Architecture


The system architecture diagram shows the MVC design pattern and the interaction between the different components of the application.  Here we can note that the model only interacts with the controllers and controllers interacts with their views.  Also, communication occurs between the TableViewController (root controller) and the other View Controllers (Details and Add/Edit controllers).


Testing

Scope: The testing of the Phonebook application will cover public methods of the Model Class and public methods implemented in the View Controller classes.  This will ensure that the functionalities of the UI and Controllers perform as expected with the Model Objects.  Private methods will not be tested since most of the interaction with them is through the Public methods.  

Goal: Ensure that all interactions with the UI, to perform the functions of the phonebook application, respond as expected, as per the application requirements.

Required Resources: 
Hardware: Mac computer with OS X (version 10.11 and up)
Software: Xcode IDE (version 7.2.1)  and OS X Server (version 5.0.15)
Repository: Git repository at Github
Testing Tool: XCTest framework, Xcode and Xcode Server service (part of OS X Server)

Dependencies:
Core Data Stack:  For testing our Model, we depend on the Core Data Stack that is created on the application launch.  To manage this and not interfere with the actual data store during testing, a In-Memory Data Store was used.  This In-Memory Data Store is similar to the application Data Store but is stored in memory instead of an actual SQLite database.

Testing Strategy:

	The testing strategy will focus on testing the main requirements of the application as they are implemented through actions or methods in the Model of our application.  All actions in the Model are implemented by public Instance or Class Methods.  Our testing strategy will develop test cases for all public methods in the model and other view controllers.

	Automation of testing will be implemented using OS X Server and Xcode.  Testing was integrated by using ‘bots’ that run on the server.  These bots process the app, using the code in the Github repository, and report the result back to Xcode.  The ‘bot’ will be scheduled to run every hour and also could be triggered by the developer at any time during the development process.

Image from https://developer.apple.com


	Testing will be performed in different iOS devices simulators to cover the different form factors currently available.  Those will be: iPhone 4S, iPhone 5, iPhone 6, iPhone 6 Plus and iPad Retina.  Also the app will be built and archived on each run to ensure correct packaging for eventual deployment.
Test Cases:

Four (4) test cases were developed to comply with the presented strategy:
Test Setup:  Before running each test a setup must be performed to ensure resources are available and configured for testing.  For this a ‘testSetup’ methods was developed.  This this setup we prepare NSDictionaries, the Core Data Stack and the fetching of objects from the data store.
testAddContact: On this case we tested the public Class Method from the Contact class to add a Contact object to the data store.  We tested for the return value and the error object passed as a pointer to the method.
testDeleteContact: On this case we tested the public Instance Method from the Contact class to delete a Contact object to the data store. We tested for the return value of the method.
testSaveContext: On this case we tested the public Class Method from the Contact class to save the Managed Object Context whenever requested and if changes were present.
testConfigureCell: On this case we tested the public Instance Method of the BaseTableViewController class to configure a UITableViewCell for displaying the Contact information to the user.

Test Reporting:

	Tests results will be reported to developers and or manager by the Xcode Server service.  This service report back results to Xcode and to a hosted ‘bots’ website.

Image from https://developer.apple.com



Xcode Test Results:

	The following is a screenshot of the test reporting summary on Xcode:



Hosted Bot Web Site:

	The following is a screenshot of the test reporting summary on the Hosted Bot Web Site:


