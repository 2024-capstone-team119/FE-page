import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/concertService.dart';

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

  Future<void> fetchPerformancesByDate(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    List<Performance> performances =
        await ConcertService.getPerformanceByDate(formattedDate);
    setPerformances(performances);
  }
}
