import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DateOverridesControllers extends GetxController {
  RxBool isStartTime = true.obs;
  RxBool isDateSelected = false.obs;

  RxString startTime = '0:00'.obs;
  RxString endTime = '0:00'.obs;
  RxString selectedDate = ''.obs;

  RxList<String> arrDates = [
    'May 21, 2022',
    'May 22, 2022',
    'May 23, 2022',
    'May 24, 2022',
    'May 25, 2022',
  ].obs;

  RxMap<String, List<String>> dictDatesTimes = {
    'May 21, 2022': [
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
    ],
    'May 22, 2022': [
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
    ],
    'May 23, 2022': [
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
    ],
    'May 24, 2022': [
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
    ],
    'May 25, 2022': [
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
      '9:00 - 17:00',
    ],
  }.obs;

  reset() {
    arrDates.clear();
    dictDatesTimes.clear();
    isDateSelected.value = false;
  }

  refresh() {
    arrDates.add('Hello');
    arrDates.removeLast();
  }

}


