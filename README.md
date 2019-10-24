

# openCX-*Mr Simba* Development Report

Welcome to the documentation pages of the Agenda Mobile App of **openCX**!

You can find here detailed information about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 

  * [Product Vision](#Product-Vision)

  * [Elevator Pitch](#Elevator-Pitch)

* Requirements

  * [Use Case Diagram](#Use-case-diagram)

  * [User stories](#User-stories)

  * [Domain model](#Domain-model)

* Architecture and Design

  * [Architectural and design decisions]()

  * [Technological architecture]()

  * [Logical architecture]()

* Implementation

  * [Source code]()

  * [Issues](): feature requests, bug fixes, improvements.

* Test

  * [Automated tests](): Functional tests, integration tests, acceptance tests, as much automated as possible.

* Change management

  * [Issues at Github]()

* Project management

  * Tasks management tool 

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

*David Silva*  

*Eduardo Ribeiro*  

*José Gomes*  

*Luís Cunha*  

## Product Vision

"A mobile app connected with the event-space to let the atendees organize themselves better and allow them to better manage their time, so they can get the best out of the conference."

## Elevator Pitch

"Have you ever found yourself in a conference spending more time keeping track of events and getting accquainted to the venue rather than networking and getting knowledge?

Our solution for that is an agenda app for your smartphone that lets you, as a participant, organize you schedule. The app let's you plan out your daily activities and warns you before it's time to do them.

However, what sets us apart from other agenda apps is our use of bluetooth beacons, that are distributed throughout the different rooms and areas of the conference. If you get close to one of them, and an activity will start shortly in that area, you will receive a push notification warning you about it, so that you are connected with everything that is happening around you."

## Requirements

As an agenda application, the main requirements of our product are connected to the display of information about the conference, to the customization of the schedules by the user and the warning/notification that an event in the schedule is about to begin. Moreover, our requirements are also influenced by the technologies that we are going to use, more specifically the use of bluetooth beacons to inform the user about nearby sessions and events, and the parsing, querying and display of the informations stored in a JSON file.

### Use case diagram 

![Use case diagram](docs/use_case_diagram_1.jpg)

Description of the use cases shown:

####  **Visualize all the conference activities in my schedule, for each day**

* **Actor**: Atendee and conference participant 

* **Description**: The users of our application need to see and know what are the various sessions in each day's schedule.

* **Preconditions and Postconditions**: The schedules need to have at least one activity in them; besides that, there are no major preconditions necessary for the use case's execution.

* **Normal Flow**:
        
    1. User, while in the main screen, navigates between the icons relative to each of the 4 days of the conference, by swiping left or right in the main screen.
    2. User taps on 1 of the 4 icons.
    3. App displays the schedule for that day.

* **Alternative Flows and Exceptions**: If the schedule for a given day is empty, the app will show some text explaning that to the user, and indicating how he or she can add sessions and activities to the schedule.

####  **Add an activity to the schedule of a certain day**

* **Actor**: Atendee and conference participant 

* **Description**: The users of our application need to be able to add sessions and activities to their schedule, so they can customize it as they wish.

* **Preconditions and Postconditions**: The system needs to have the correct and updated information to show the user, regarding the activities for that day, so that the app user can choose those which might be of their interest.

* **Normal Flow**:
        
    1. System is displaying the different activities of the conference for that day.
    2. User picks the activity that he/she wants and swipes to the left, revealing an "add" button.
    3. User clicks the button.
    4. System redirects to the schedule page, showing that the activity was indeed added.

* **Alternative Flows and Exceptions**: If the user tries to add an activity that is already in the schedule, it obviously will have no effect.

####  **Create a custom activity for the schedule**

* **Actor**: Atendee and conference participant

* **Description**: This can be considered as a sub-use case of adding an activity. The goal is to let the users of the application have in their schedule not only the sessions that they want to attend, but also every other activity related to the conference, such as, for example, a meeting, a reunion, having lunch, etc.

* **Preconditions and Postconditions**: There are no major preconditions that have to be met before the start of this use case. After its execution, the activity crated will be added to the day's schedule.

* **Normal Flow**:
        
    1. User selects the option to create a custom activity, in the schedule of a given day.
    2. User inputs the needed fields to characterize the custom session (title, location, start time, etc).
    3. System creates the custom event and adds it to the schedule

* **Alternative Flows and Exceptions**: If the user enters any invalid input or any required fields are left blank, the application will not create the custom activity and will ask the user to fill in all the fields correctly.


####  **Remove an activity from the schedule of a certain day**

* **Actor**: Atendee and conference participant 

* **Description**: The users of our application need to be able to remove sessions and activities from their schedule, so they can customize it as they wish.

* **Preconditions and Postconditions**: There must be, obviously, at least one activity in the schedule, if we want to remove.

* **Normal Flow**:
        
    1. System is displaying the different activities of the schedule.
    2. User picks the activity that he/she wants and swipes to the left, revealing a "remove" button.
    3. User clicks the button.
    4. System deletes that session from the schedule, no longer displaying it.

* **Alternative Flows and Exceptions**: As said before, is the schedule has no activities, the user can't remove anything.

####  **Get a push notification when an activity in the schedule is about to start**

* **Actor**: Atendee and conference participant 

* **Description**: In order to remind the user that an activity in the schedule is about to start, roughly 10 minutes before said activity the app will generate a push notification with that information.

* **Preconditions and Postconditions**: The app must know the current time and at what time the activity starts, so as to calculate how much time left there is before the session starts, and to know when to warn the user.

* **Normal Flow**:
        
    1. System compares current time to the start time of the sessions in the schedule.
    2. System detects that in less than 10 minutes a session will begin.
    3. Application generates a push notification to warn the user.
    4. User sees the push notification and is informed.

* **Alternative Flows and Exceptions**: As said before, if the application cannot keep track of time, no notification is going to be generated.

####  **Get custom translated information to help me navigate in a foreign place**

* **Actor**: Foreign atendee 

* **Description**: In order to accommodate and help foreign atendees, the app should be able to display its content in several languages.

* **Preconditions and Postconditions**: There are no major preconditions for this use case. In terms of postconditions, after the language change, all text the system displays will be in that language.

* **Normal Flow**:
        
    1. User goes to the "language select" menu.
    2. User selects the desired language.
    3. System changes content to be displayed in that language.

* **Alternative Flows and Exceptions**: No major alternative flows and exceptions are expected.

####  **Get a push notification about an activity ocurring in a nearby place**

* **Actor**: Atendee and bluetooth beacon network

* **Description**: In order to integrate the user in the conference environment and inform him/her about some activities that might be of his/her interest, the application (if close enough) will connect with a bluetooth beacon, placed in the different rooms and locations of the conference, generating a push notification if a session in that location is about to begin or is underway.

* **Preconditions and Postconditions**: The phone should be able have the capability to connect with the bluetooth beacons, and the app needs be "aware" of time in order to calculate if a session on that location is about to begin or is underway. Moreover, the beacon must be capable of transmiting the needed information to the application.

* **Normal Flow**:
        
    1. User is in a certain location, staying still or moving around.
    2. Phone is close enough to a bluetooth beacon, connecting itself to it.
    3. Beacon sends to the application information about the next session that is going to take place in that location.
    4. Application calculates that that session is about to begin or is underway.
    5. Application generates push notification to warn the user.
    6. User sees the notification and is informed.

* **Alternative Flows and Exceptions**: If any of the preconditions are not met (for example, phone has bluetooth disabled or beacon cannot send information), this process will not be able to execute and the app will not generate any push notifications. This will also happen, of course, if the phone is out of range of the bluetooth beacons.


####  **Access the information about the conference sessions, people and items**

* **Actor**: Atendee, conference participant and server/internet. 

* **Description**: The users of our application need to see and know what are the various sessions offered by the conference, so they can understand what activities they are interested in, in order to build a schedule.

* **Preconditions and Postconditions**: The system needs to be able to estabilish a connection to the server, in order to get a JSON file contaning all the information. After this use case the user can now choose what sessions he or she wants to add to the schedule.

* **Normal Flow**:
        
    1. User taps button to see the available activities for that day.
    2. App queries the JSON file to get the information about the sessions for that day.
    3. App displays that information to the user.

* **Alternative Flows and Exceptions**: If the application does not have access to the JSON file or the user demands to refresh the page, the system contacts the server in order to get the JSON file.

####  **Update the app's information about an event im organizing**

* **Actor**: Conference participant

* **Description**: In order to maintain and keep all the information about the sessions as recent as possible, the conference participants and speakers should be able to update that information whenever is necessary.

(we are still unsure about how we're going to implement this use case, so we have decided to leave the rest of the fields blank for now).



### User stories

**[fazer map, com roles e themes]**

### #1

> "As a participant or speaker in the conference, I want the application to help me find activities that might be of my interest, and keep my schedule for the different days of the conference so that I can be more organized."
>
> * **Importance:** Must have
> * **Effort to implement:** M 


### #2

> "As a user I want to make my own personalized schedule for each day, according to my interests."
>
> * **Importance:** Must have
> * **Effort to implement:** M 


### #3

> "As a user I want to be informed, minutes before, that a session that is in my schedule is going to start, so that I don't miss activities that are of my interest."
>
> * **Importance:** Should have
> * **Effort to implement:** M 


### #4
> "As a participant of the conference that is not familiar with the surroundings of the conference, I would like to know when i'm passing through locations or rooms that are hosting events that begin shortly or have already started."
>
> * **Importance:** Should have
> * **Effort to implement:** L 


### #5
> "As a participant in the conference, I would like to to create and add my own custom activities to my schedule (eg: having, lunch, meeting with friends, reunions, etc), so I can have in my schedule everything that is related to the conference."
>
> * **Importance:** Could have
> * **Effort to implement:** S 


### #6
> "As an application user, I would like to obtain updated information about the sessions of the conference, as well as their contents (items being presented) and the people participating, so I can now more about the activities and choose those which interest me."
>
> * **Importance:** Should have
> * **Effort to implement:** M


### #7
> "As a foreign atendee, I would like that the application showed its contents in my language, so I can have a better understanding of the information displayed."
>
> * **Importance:** Could have
> * **Effort to implement:** M 



### Domain model

![Domain Model](docs/domain_model.png)

---

## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
Regular product increments are a good practice of product management. 

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.
 
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

The project management tool that we decided to adopt was Trello.


**[imagem ou link]**
