import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Controllers/DateOverridesControllers.dart';
import 'package:get/get.dart';
import '../Styles/ColorStyle.dart';
import '../Components/CalendarCustom.dart';
import 'package:flutter/cupertino.dart';

class DateOverrides extends StatelessWidget {
  DateOverrides({Key? key}) : super(key: key);

  final controller = Get.put(DateOverridesControllers());

  timeInterval(int index, int jIndex) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
          elevation: 0,
          primary: Colors.transparent,
          maximumSize: Size(160, 50),
          minimumSize: Size(160, 50),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: ColorStyle.secondryBlack,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2))),
      child: Text(
        controller.dictDatesTimes[controller.arrDates[index]]![jIndex],
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Palatino',
          color: ColorStyle.secondryBlack,
        ),
      ),
      onPressed: () {
        controller.isDateSelected.value = false;
        iOSDatePicker(index, jIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DateOverridesControllers(),
      initState: (state) {
        controller.reset();
      },
      builder: (auth) {
        return Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  CalendarCustom(onDaySelected: (selectedDate) {
                    final DateFormat formatter = DateFormat('MMM dd, yyyy');
                    controller.selectedDate.value =
                        formatter.format(selectedDate);
                    print(controller.selectedDate.value);

                    controller.isDateSelected.value = true;

                    iOSDatePicker(0, 1);
                  }),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 14, bottom: 14),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: ColorStyle.grey, width: 1),
                            bottom:
                                BorderSide(color: ColorStyle.grey, width: 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Israel Standard Time',
                          style: TextStyle(
                              color: ColorStyle.blue,
                              fontSize: 16,
                              fontFamily: 'Palatino',
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 14, bottom: 14),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: ColorStyle.grey, width: 1))),
                    child: Text(
                      'Availablity for specific dates',
                      style: TextStyle(
                          color: ColorStyle.grey,
                          fontSize: 18,
                          fontFamily: 'Palatino',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.arrDates.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Colors.grey,
                        height: 0.5,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  controller.arrDates[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Palatino',
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .dictDatesTimes[
                                            controller.arrDates[index]]!
                                        .length,
                                    itemBuilder: (context, jIndex) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              Icons.cancel,
                                              color: ColorStyle.grey,
                                              size: 26,
                                            ),
                                            onTap: () {
                                              print(jIndex);

                                              List<String> arrDatesGet =
                                                  controller.dictDatesTimes[
                                                      controller
                                                          .arrDates[index]]!;

                                              if (arrDatesGet.length == 1) {
                                                controller.dictDatesTimes
                                                    .remove(controller
                                                        .arrDates[index]);
                                                controller.arrDates
                                                    .removeAt(index);
                                              } else {
                                                arrDatesGet.removeAt(jIndex);
                                              }

                                              controller.refresh();
                                            },
                                          ),
                                          SizedBox(width: 10),
                                          timeInterval(index, jIndex),
                                          SizedBox(width: 10),
                                          InkWell(
                                            child: Icon(
                                              Icons.add,
                                              color: ColorStyle.blue,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              List<String> arrDatesGet =
                                                  controller.dictDatesTimes[
                                                      controller
                                                          .arrDates[index]]!;
                                              arrDatesGet.add('Unavailable');
                                              controller.refresh();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, jIndex) {
                                      return Container(
                                        height: 6,
                                      );
                                    }))
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}

iOSDatePicker(int index, int jIndex) {
  print(index);
  print(jIndex);

  final controller = Get.put(DateOverridesControllers());

  return Get.bottomSheet(
    GetBuilder(
      init: DateOverridesControllers(),
      initState: (state) {},
      builder: (auth) {
        return Obx(() => Container(
              height: 326,
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: controller.isStartTime.value
                                    ? ColorStyle.primaryWhite
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Start time',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Palatino',
                                      color: ColorStyle.secondryBlack),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  controller.startTime.value,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Palatino',
                                      color: ColorStyle.secondryBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            controller.isStartTime.value = true;
                          },
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: !controller.isStartTime.value
                                  ? ColorStyle.primaryWhite
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'End time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Palatino',
                                    color: ColorStyle.secondryBlack),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                controller.endTime.value,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Palatino',
                                    color: ColorStyle.secondryBlack,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          controller.isStartTime.value = false;
                        },
                      )),
                    ],
                  ),
                  Container(
                    height: 30,
                    color: ColorStyle.primaryWhite,
                  ),
                  Container(
                    height: 100,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newdate) {
                        final DateFormat formatter = DateFormat('HH:mm');
                        final String formatted = formatter.format(newdate);

                        if (controller.isStartTime.value) {
                          controller.startTime.value = formatted;
                        } else {
                          controller.endTime.value = formatted;
                        }
                      },
                      use24hFormat: true,
                      maximumDate: new DateTime(2050, 12, 30),
                      minimumYear: 2010,
                      maximumYear: 2018,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.time,
                    ),
                  ),
                  Container(
                    height: 16,
                    color: ColorStyle.primaryWhite,
                  ),
                  Container(
                    color: ColorStyle.primaryWhite,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ColorStyle.blue,
                              elevation: 0,
                              minimumSize: Size(Get.size.width - 40, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: Text(
                            'Use these times',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Palatino',
                              color: ColorStyle.primaryWhite,
                            ),
                          ),
                          onPressed: () {
                            if (controller.isDateSelected.value) {
                              var arrDatesTimes = controller
                                  .dictDatesTimes[controller.selectedDate.value];

                              if (arrDatesTimes == null) {
                                controller.arrDates
                                    .add(controller.selectedDate.value);

                                arrDatesTimes = [
                                  controller.startTime.value +
                                      ' - ' +
                                      controller.endTime.value
                                ];
                                controller.dictDatesTimes[controller
                                    .selectedDate.value] = arrDatesTimes;
                              } else {
                                arrDatesTimes.add(controller.startTime.value + ' - ' + controller.endTime.value);
                                controller.dictDatesTimes[controller.selectedDate.value] = arrDatesTimes;
                              }
                            } else {
                              var arrDatesTimes = controller.dictDatesTimes[controller.arrDates[index]];
                              arrDatesTimes![jIndex] = controller.startTime.value + ' - ' + controller.endTime.value;
                              controller.dictDatesTimes[controller.selectedDate.value] = arrDatesTimes;
                            }

                            controller.refresh();
                            Get.back();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: ColorStyle.blue,
                              primary: Colors.transparent,
                              elevation: 0,
                              minimumSize: Size(Get.size.width - 40, 50),
                              shape: RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.circular(50)
                                  )),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Palatino',
                                color: ColorStyle.secondryBlack),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        SafeArea(
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    ),
  );
}
