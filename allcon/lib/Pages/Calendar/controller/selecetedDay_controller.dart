import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:allcon/model/performance_model.dart';

class SelectedDayController extends GetxController {
  late DateTime _selectedDay = DateTime.now();
  late List<Performance> performances = [];

  DateTime get selectedDay => _selectedDay;

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    update();
  }

  void setPerformances(List<Performance> newPerformances) {
    performances = newPerformances;
    update();
  }

  List<Performance> getEventsForDay(DateTime day) {
    return performances.where((performance) {
      DateTime startDate =
          DateFormat("yyyy.MM.dd").parse(performance.startDate!);
      DateTime endDate = DateFormat("yyyy.MM.dd").parse(performance.endDate!);
      return (startDate.isBefore(day) || startDate.isAtSameMomentAs(day)) &&
          (endDate.isAfter(day) || endDate.isAtSameMomentAs(day));
    }).toList();
  }
}
