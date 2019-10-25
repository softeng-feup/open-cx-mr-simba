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

A mobile app connected with the event-space to let the atendees organize themselves better and allow them to better manage their time, so they can get the best out of the conference.

## Elevator Pitch


### Version 1.a
Our idea for a product that would let the atendees of the conference have a better experience is an agenda application that lets the participants to better organize their schedule. Our app will let the users plan their schedule for each one of the 4 days of the conference. They can of course add and remove activities from their schedule as they will.

Also, to remind the user that an activity is about to begin, the app will send a push notification approximately 5/10 mins before each activity, so they don't forget it.

However, what sets us apart from other agenda apps is our use of bluetooth beacons, that are distributed throughout the different rooms and areas of the conference. If a user gets close to one of them, and an activity will start shortly in that area, they will receive a push notification warning them about it, so they are informed about everything that is happening around them.

### Version 1.b
Have you ever found yourself in a conference spending more time keeping track of events and getting accquainted to the venue rather than networking and getting knowledge?
Our solution for that is an agenda app for your smartphone that lets you, as a participant, organize you schedule. The app let's you plan out your daily activities and warns you before it's time to do them.

However, what sets us apart from other agenda apps is our use of bluetooth beacons, that are distributed throughout the different rooms and areas of the conference. If you get close to one of them, and an activity will start shortly in that area, you will receive a push notification warning you about it, so that you are connected with everything that is happening around you.

### Version 2.a
Have you ever found yourself in a conference spending more time keeping track of events and getting accquainted to the venue rather than networking and getting knowledge?
Our solution for that is an agenda app for your smartphone that lets you, as a participant, organize you schedule. The app let's you plan out your daily activities and warns you before it's time to do them.

However, what sets us apart from other agenda apps is that our app is connected with the event space and, as such, you get custom location-related notifications. If you get close to one of them, and an activity will start shortly in that area, you will receive a push notification warning you about it, so that you are connected with everything that is happening around you.


## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram 

### Todo  list:
- [ ] Use-case diagram
- [ ] Use-case naming
- [ ] Use-case description
 

![Use case diagram](docs/use_case_diagram_1.jpg)

Briefly describe each use case mentioning the following:

* **Actor**. Name only the actor that will be initiating this use case, i.e. a person or other entity external to the software system being specified who interacts with the system and performs use cases to accomplish tasks. 
* **Description**. Provide a brief description of the reason for and outcome of this use case, or a high-level description of the sequence of actions and the outcome of executing the use case. 
* **Preconditions and Postconditions**. Include any activities that must take place, or any conditions that must be true, before the use case can be started (preconditions) and postconditions. Describe also the state of the system at the conclusion of the use case execution (postconditions). 

* **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system. 
* **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions. 

### User stories

### Todo list
- [x] User story descriptions
- [ ] MoSCow Notation
- [ ] Story Map
- [ ] Acceptance tests
- [ ] Mockups


### #1

> As a participant or speaker in the conference, I want the application to help me find activities that might be of my interest, and keep my schedule for the different days of the conference so that I can be more organized.

### #2
> As a user I want to make my own personalized schedule for each day, according to my interests.

### #3

> As a user I want to be informed, minutes before, that a session that is in my schedule is going to start, so that I don't miss activities that are of my interest.

### #4
> As a foreign atendee of the conference, now knowing the country and venue where it is taking place, I would like to known when I pass by points of interest such as rooms where activities of my liking are going to happen and/or bathrooms, places to eat, so that I feel less difficulty in being a foreign country.

### #5
> As an atendee of the conference I would like to be able to create my own activities and add them to the schedule (example: have lunch, meet up with collegues, business-meetings, etc.) so that I can have in the same app everything I do that is related to the conference. 

### #6
> As an atendee of the the conference I would like to give the app my areas of interest so that the app may suggest sessions and/or activities that are of my interest.

### #7
> As an atendee of the conference I would like to be able to find my exact location in the venue so that I don't get lost.

### #8
> As an organizer of the conference I would like to get insights on the conference (attending numbers, heat maps of concentration of people, favorite topics ) so that I may know how I can improve the experience at the conference and any future ones

### #9
> As an atendee of the conference I would like to be able to add my friends and collegues to a friend's list in the app so that I am aware if people I know are attending the same conference as I am.

### #10
> As a conference organizer I would like to be able to give sponsors a place where they can advertise to the atendees of the conference so that I have a away of finance the conference and any future events.

### Domain model


![Domain Model](docs/domain_model.jpg)
A simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.



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

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.
