import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckNumDayActivitiesStepGiven extends Given2WithWorld<int, String, FlutterWorld> {
  CheckNumDayActivitiesStepGiven()
    : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep(int dayNumber, String expectedNumActivities) async {

    final pv = find.byValueKey('pageview');
    await world.driver.waitFor(pv, timeout: timeout);


    for(int i = 1; i < dayNumber; i++) {
      await world.driver.scroll(pv, -400, 0, Duration(milliseconds: 500));
    }

    final locator = find.byValueKey("numberOfActivitiesDay");
    String text = await world.driver.getText(locator, timeout: Duration(seconds: 2));

    expect(text, expectedNumActivities);
  }

  @override
  RegExp get pattern => RegExp(r"Given I expect the number of activities of day {int} to be {string}");
}


class CheckNumDayActivitiesStepAnd extends And1WithWorld<String, FlutterWorld> {
  CheckNumDayActivitiesStepAnd()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep(String expectedNumActivities) async {
    final backButton = find.byValueKey("Back button");
    await world.driver.tap(backButton);

    final locator = find.byValueKey("numberOfActivitiesDay");
    String text = await world.driver.getText(locator, timeout: Duration(seconds: 2));

    expect(text, expectedNumActivities);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the number of activities of that day to be {string}");
}


class CheckNumDayActivitiesStepThen extends Then1WithWorld<String, FlutterWorld> {
  CheckNumDayActivitiesStepThen()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep(String expectedNumActivities) async {
    final backButton = find.byValueKey("Back button");
    await world.driver.tap(backButton);

    final locator = find.byValueKey("numberOfActivitiesDay");
    String text = await world.driver.getText(locator, timeout: Duration(seconds: 2));

    expect(text, expectedNumActivities);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the number of activities of that day to be {string}");
}






class AddSessionStep extends When1WithWorld<int, FlutterWorld> {
  AddSessionStep()
    : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep(int dayNumber) async {
    String calendarPage = "Calendar page - " + dayNumber.toString();

    final calendarLocator = find.byValueKey(calendarPage);
    await world.driver.tap(calendarLocator);
    final addButtonLocator = find.byValueKey("Adding button");
    await world.driver.tap(addButtonLocator);

    final slider = find.byType('Slidable');
    await world.driver.scroll(slider, -200, 0, Duration(milliseconds: 500));
    final slideButton = find.byValueKey("Slidable button");
    await world.driver.tap(slideButton);
  }

  @override
  RegExp get pattern => RegExp(r"I add a certain session in the day {int} schedule");
}



class VerifySessionExistsStep extends ThenWithWorld<FlutterWorld> {
  VerifySessionExistsStep()
    : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep() async {
    final backButton = find.byValueKey("Back button");
    await world.driver.tap(backButton);

    final locator = find.byValueKey("Session title");
    String text = await world.driver.getText(locator, timeout: Duration(seconds: 2));

    expect(text, "Random Session");
  }

  @override
  RegExp get pattern => RegExp(r"that schedule should contain that session");
}



class RemoveSessionStep extends ButWithWorld<FlutterWorld> {
  RemoveSessionStep()
    : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep() async {
    final slider = find.byType('Slidable');
    await world.driver.scroll(slider, -200, 0, Duration(milliseconds: 500));
    final slideButton = find.byValueKey("Slidable button");
    await world.driver.tap(slideButton);
  }

  @override
  RegExp get pattern => RegExp(r"if I remove that session from the schedule");
}