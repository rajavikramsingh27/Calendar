import 'package:availablity/Styles/ColorStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/SwitchButtonCustom.dart';
import '../Controllers/WeeklyHoursController.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';


class WeeklyHours extends StatelessWidget {
  WeeklyHours({Key? key}) : super(key: key);

  final controller = Get.put(WeeklyHoursController());

  timeInterval(int index, int jIndex) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
          elevation: 0,
          primary: Colors.transparent,
          maximumSize: Size(130, 50),
          minimumSize: Size(130, 50),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: controller.arrWeekOn[index]
                    ? ColorStyle.secondryBlack
                    : ColorStyle.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2))),
      child: AutoSizeText(
        controller.arrWeekTimeInterval[index][jIndex],
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Palatino',
          color: controller.arrWeekOn[index]
              ? ColorStyle.secondryBlack
              : ColorStyle.grey,
        ),
      ),
      onPressed: () {
        if (controller.arrWeekOn[index]) {
          iOSDatePicker(index, jIndex);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: WeeklyHoursController(),
        initState: (state) {
          controller.isSwitchOn.value.toString();
        },
        builder: (auth) {
          return Obx(() => ListView.separated(
                itemCount: controller.arrWeekNames.length,
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
                        Row(
                          children: [
                            SwitchButtonCustom.switchButton(
                                controller.arrWeekOn[index], (toggleValue) {
                              controller.arrWeekOn[index] =
                                  !controller.arrWeekOn[index];
                              controller.refresh();

                              if (!controller.arrWeekOn[index]) {
                                controller.arrWeekTimeInterval[index].value = ['Unavailable'];
                              } else {
                                // iOSDatePicker(index, 0);
                              }
                            }),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              width: 80,
                              child: AutoSizeText(
                                controller.arrWeekNames[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Palatino',
                                ),
                                minFontSize: 11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: controller.arrWeekTimeInterval[index].length,
                                itemBuilder: (context, jIndex) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (jIndex != 0)
                                        InkWell(
                                          child: Icon(
                                            Icons.cancel,
                                            color: ColorStyle.grey,
                                            size: 26,
                                          ),
                                          onTap: () {
                                            print(jIndex);

                                            controller.arrWeekTimeInterval[index].removeAt(jIndex);

                                            // controller.arrWeekTimeIntervalCount[
                                            //     index] -= 1;
                                            controller.refresh();
                                          },
                                        ),
                                      if (jIndex != 0) SizedBox(width: 10),
                                      timeInterval(index, jIndex),
                                      SizedBox(width: 10),
                                      InkWell(
                                        child: Icon(
                                          Icons.add,
                                          color: controller.arrWeekOn[index]
                                              ? ColorStyle.blue
                                              : ColorStyle.grey,
                                          size: 30,
                                        ),
                                        onTap: () {
                                          if (controller.arrWeekOn[index]) {

                                            controller.arrWeekTimeInterval[index].add('Unavailable');
                                            // controller.arrWeekTimeIntervalCount[
                                            //     index] += 1;
                                            controller.refresh();
                                          }
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
              ));
        });
  }
}

iOSDatePicker(int index, int jIndex) {
  final controller = Get.put(WeeklyHoursController());

  return Get.bottomSheet(
    GetBuilder(
      init: WeeklyHoursController(),
      initState: (state) {

      },
      builder: (auth) {
        return Obx(()=>Container(
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
                            color: controller.isStartTime.value ? ColorStyle.primaryWhite : Colors.transparent,
                            borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6)
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start time',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Palatino',
                                  color: ColorStyle.secondryBlack
                              ),
                            ),
                            SizedBox(height: 6,),
                            Text(
                              controller.startTime.value,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Palatino',
                                  color: ColorStyle.secondryBlack,
                                  fontWeight: FontWeight.bold
                              ),
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
                              color: !controller.isStartTime.value ? ColorStyle.primaryWhite : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6)
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'End time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Palatino',
                                    color: ColorStyle.secondryBlack
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                controller.endTime.value,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Palatino',
                                    color: ColorStyle.secondryBlack,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          controller.isStartTime.value = false;
                        },
                      )
                  ),
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
                      controller.minEndDate.value = newdate;
                    } else {
                      controller.endTime.value = formatted;
                    }
                  },
                  use24hFormat: true,
                  // maximumDate: DateTime(2050, 12, 30),
                  minimumDate: controller.isStartTime.value ? DateTime(1970, 12, 30) : controller.minEndDate.value,
                  // minimumYear: 2010,
                  // maximumYear: 2018,
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
                              borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      child: Text(
                        'Use these times',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Palatino',
                            color: ColorStyle.primaryWhite
                        ),
                      ),
                      onPressed: () {
                        controller.arrWeekOn[index] = true;
                        controller.arrWeekTimeInterval[index][jIndex] = controller.startTime.value+' - '+controller.endTime.value;
                        controller.refresh();
                        Get.back();
                      },
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: ColorStyle.blue,
                          primary: Colors.transparent,
                          elevation: 0,
                          minimumSize: Size(Get.size.width - 40, 50),
                          shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(50)
                          )
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Palatino',
                            color: ColorStyle.secondryBlack
                        ),
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
