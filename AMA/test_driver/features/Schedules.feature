Feature: Schedules
  As a conference participant
  I want to be able to have my own schedule and personalize it
  So I can keep track of my activities and organize myself better.


  Scenario: Remove a session from a schedule
    Given I expect the number of activities of day 3 to be "0 activities"
    When I add a certain session in the day 3 schedule
    Then that schedule should contain that session
    But if I remove that session from the schedule
    Then I expect the number of activities of that day to be "0 activities"


  Scenario: Add sessions to a schedule
    Given I expect the number of activities of day 3 to be "0 activities"
    When I add a certain session in the day 3 schedule
    Then that schedule should contain that session
    And I expect the number of activities of that day to be "1 activity"
