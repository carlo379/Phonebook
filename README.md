# Phonebook
Simple Phonebook application for the iOS family of devices (Universal Application).  

#Scope 
The testing of the Phonebook application will cover public methods of the Model Class and public methods implemented in the View Controller classes.  This will ensure that the functionalities of the UI and Controllers perform as expected with the Model Objects.  Private methods will not be tested since most of the interaction with them is through the Public methods.  

#Goal
Ensure that all interactions with the UI, to perform the functions of the phonebook application, respond as expected, as per the application requirements.

#Required Resources
Hardware: Mac computer with OS X (version 10.11 and up)
Software: Xcode IDE (version 7.2.1)  and OS X Server (version 5.0.15)
Repository: Git repository at Github
Testing Tool: XCTest framework, Xcode and Xcode Server service (part of OS X Server)

#Dependencies
Core Data Stack:  For testing our Model, we depend on the Core Data Stack that is created on the application launch.  To manage this and not interfere with the actual data store during testing, a In-Memory Data Store was used.  This In-Memory Data Store is similar to the application Data Store but is stored in memory instead of an actual SQLite database.

#System Architecture
The system architecture diagram shows the MVC design pattern and the interaction between the different components of the application.  Here we can note that the model only interacts with the controllers and controllers interacts with their views.  Also, communication occurs between the TableViewController (root controller) and the other View Controllers (Details and Add/Edit controllers).
