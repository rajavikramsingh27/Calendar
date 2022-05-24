import 'package:get/get.dart';

class WeeklyHoursController extends GetxController {
  RxBool isWeeklyHours = true.obs;
  RxBool isSwitchOn = false.obs;
  RxBool isStartTime = true.obs;

  RxString startTime = '0:00'.obs;
  RxString endTime = '0:00'.obs;

  Rx<DateTime> minEndDate = DateTime.now().obs;

  RxList<String> arrWeekNames = [
    'Sundays',
    'Mondays',
    'Tuedays',
    'Wednesdays',
    'Thursdays',
    'Fridays',
    'Saturdays',
  ].obs;

  RxList<bool> arrWeekOn = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;

  RxList<RxList<String>> arrWeekTimeInterval = [
    ['Unavailable'].obs,
    ['Unavailable'].obs,
    ['Unavailable'].obs,
    ['Unavailable'].obs,
    ['Unavailable'].obs,
    ['Unavailable'].obs,
    ['Unavailable'].obs,
  ].obs;

  refresh() {
    arrWeekNames.add('Hello');
    arrWeekNames.removeLast();
  }
}
