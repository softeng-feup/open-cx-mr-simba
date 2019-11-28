Feature: Drawer
  Tests that verify the correct functioning of the app drawer in the main screen.

  Scenario: Selecting the first drawer option
    Given I open the drawer
    When I tap the "About tile" widget
    Then I expect the "Screen title" to be "About"

  Scenario: Selecting the second drawer option
    Given I open the drawer
    When I tap the "Session search tile" widget
    Then I expect the "Screen title" to be "Session Search"

  Scenario: Selecting the third drawer option
    Given I open the drawer
    When I tap the "Locations tile" widget
    Then I expect the "Screen title" to be "All conference locations"
