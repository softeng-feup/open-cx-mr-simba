Feature: Schedules
  As a conference participant
  I want to be able to have my own schedule and personalize it
  So I can keep track of my activities and organize myself better.

  Scenario: Add sessions to a schedule
    Given I have a schedule for a certain day
    When I add a session to it
    Then the schedule should contain that session


  Scenario: Remove a session from a schedule
    Given I have a schedule with a certain session in it
    When I remove that session from the schedule
    Then the schedule should not contain the session anymore