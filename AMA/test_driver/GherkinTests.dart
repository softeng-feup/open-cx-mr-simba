import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/PagerSteps.dart';
import 'steps/ScheduleSteps.dart';
import 'steps/FeaturedSpeakersSteps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = [PagerStepWhen(), PagerStepAnd(), PagerStepGiven(), CheckNumDayActivitiesStepGiven(), CheckNumDayActivitiesStepAnd(), CheckNumDayActivitiesStepThen(), AddSessionStep(), VerifySessionExistsStep(), RemoveSessionStep(), FeaturedSpeakerClick(), FeaturedSpeakerCheckName()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/Gherkin.dart"
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}