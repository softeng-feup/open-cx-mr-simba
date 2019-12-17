import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'dart:convert';

class PagerStepGiven extends Given2WithWorld<String, int, FlutterWorld> {
  PagerStepGiven()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String direction, int numberOfSwipes) async {

    final pv = find.byValueKey('pageview');
    await world.driver.waitFor(pv, timeout: timeout);

    double scrollValue = 0;
    if(direction == 'right')
      scrollValue = -400;
    else if(direction == 'left')
      scrollValue = 400;

    for(int i = 0; i < numberOfSwipes; i++) {
      await world.driver.scroll(pv, scrollValue, 0, Duration(milliseconds: 500));
    }
  }

  @override
  RegExp get pattern => RegExp(r"I scroll to the (right|left) for {int} times");
}


class FeaturedSpeakerClick extends When1WithWorld<int, FlutterWorld> {
  FeaturedSpeakerClick()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(int speakerNumber) async {
    String speakerString = "Featured Speaker - " + speakerNumber.toString();

    final speakerLocator = find.byValueKey(speakerString);
    await world.driver.tap(speakerLocator);
  }

  @override
  RegExp get pattern => RegExp(r"I click on the featured speaker number {int}");
}


class FeaturedSpeakerCheckName extends Then1WithWorld<String, FlutterWorld> {
  FeaturedSpeakerCheckName()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(String speakerName) async {
      final locator = find.byValueKey("Person Identification");
      String text = await world.driver.getText(locator, timeout: Duration(seconds: 2));
      LineSplitter ls = new LineSplitter();
      List<String> lines = ls.convert(text);
      String personName = lines.elementAt(0);

      expect(personName, speakerName);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the name of the person in the profile to be {string}");
}