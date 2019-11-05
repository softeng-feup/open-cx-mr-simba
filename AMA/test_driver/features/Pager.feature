Feature: Pager
  Tests that verify the correct functioning of the pager in the main screen.

  Scenario: Swiping right to use the pager
    Given I expect the "identifierDay" to be "#1"
    When I scroll to the right for 3 times
    Then I expect the "identifierDay" to be "#4"


  Scenario: Swiping left to use the pager
    Given I expect the "identifierDay" to be "#1"
    When I scroll to the right for 3 times
    And I scroll to the left for 2 times
    Then I expect the "identifierDay" to be "#2"