import 'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';

class AddSessionStep extends When1WithWorld<int, FlutterWorld> {
  AddSessionStep()
    : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 40));

  @override
  Future<void> executeStep(int dayNumber) {

    // for(i)
  }

  @override
  RegExp get pattern => RegExp(r"I have a schedule for day (1|2|3|4) that has no activities");
}