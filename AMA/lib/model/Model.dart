import 'DayScheduleInfo.dart';
import '../constants/Dates.dart' as Dates;

class Model {

  List<DayScheduleInfo> _daySchedule = [];
  String _jsonURL;

  Model() {
    _daySchedule.add(DayScheduleInfo(1, Dates.date1));
    _daySchedule.add(DayScheduleInfo(2, Dates.date2));
    _daySchedule.add(DayScheduleInfo(3, Dates.date3));
    _daySchedule.add(DayScheduleInfo(4, Dates.date4));
  }

  List<DayScheduleInfo> getSchedules() {
    return _daySchedule;
  }

  void setJsonURL(String url) {
    _jsonURL = url;
  }

  String getJsonURL() {
    return _jsonURL;
  }
}