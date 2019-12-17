Feature: Featured Speakers
  Testing the presentation and display of the featured speakers for a certain day.

  Scenario: Entering the profile of a featured speaker
    Given I scroll to the right for 2 times
    When I click on the featured speaker number 1
    Then I expect the name of the person in the profile to be "Philipp Haller"