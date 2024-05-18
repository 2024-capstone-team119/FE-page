import 'package:get/get.dart';
import 'package:allcon/model/performance_model.dart';
import 'package:allcon/service/concertLikesService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConcertLikesController extends GetxController {
  RxList<Performance> favoritePerformances = <Performance>[].obs;
  String? loginUserId;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  void loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
    if (loginUserId != null) {
      await loadFavoritePerformances();
    }
  }

  Future<void> loadFavoritePerformances() async {
    try {
      List<Performance> performances =
          await ConcertLikesService.getFavoritePerformances(loginUserId!);
      favoritePerformances.assignAll(performances);
    } catch (e) {
      print('Failed to load favorite performances: $e');
    }
  }

  Future<void> toggleFavorite(String performanceId) async {
    await ConcertLikesService.toggleFavorite(loginUserId!, performanceId);
    await loadFavoritePerformances();
  }
}
