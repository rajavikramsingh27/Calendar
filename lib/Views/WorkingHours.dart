import 'package:flutter/material.dart';
import '../Styles/ColorStyle.dart';
import 'package:get/get.dart';
import '../Controllers/WeeklyHoursController.dart';
import '../Views/WeeklyHours.dart';
import '../Views/DateOverrides.dart';


class WorkingHours extends StatelessWidget {
  WorkingHours({Key? key}) : super(key: key);

  final controller = Get.put(WeeklyHoursController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyle.primaryWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorStyle.primaryWhite,
          centerTitle: true,
          title: Text(
            'Working Hours',
            style: TextStyle(color: ColorStyle.secondryBlack,
            fontFamily: 'Palatino',
              fontWeight: FontWeight.w500
            ),
          ),
          leadingWidth: 80,
          leading: TextButton(
            child: Text(
              'Close',
              style: TextStyle(
                color: ColorStyle.blue,
                fontSize: 16,
                fontFamily: 'Palatino',
              ),
            ),
            onPressed: () {},
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: ColorStyle.blue,
                        fontSize: 16,
                        fontFamily: 'Palatino',
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
        body: GetBuilder(
          init: WeeklyHoursController(),
          initState: (state) {},
          builder: (auth) {
            return Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      'Set typical weekly hours and add overrides for specific dates',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorStyle.secondryBlack,
                        fontFamily: 'Palatino',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          splashColor: ColorStyle.blue,
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.only(
                              bottom: 10, left: 6, right: 6,
                            ),
                            decoration: BoxDecoration(
                                border: controller.isWeeklyHours.value ? Border(
                                    bottom: BorderSide(
                                      color: ColorStyle.blue,
                                      width: 4,
                                    )) : Border(
                                    bottom: BorderSide(
                                      color: Colors.transparent,
                                      width: 4,
                                    )
                                )
                            ),
                            child: Text(
                              'Weekly hours',
                              style: TextStyle(
                                color: controller.isWeeklyHours.value ? ColorStyle.secondryBlack : ColorStyle.secondryBlack.withOpacity(0.5),
                                fontWeight: controller.isWeeklyHours.value ? FontWeight.w600 : FontWeight.normal,
                                fontSize: 18,
                                fontFamily: 'Palatino',
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.isWeeklyHours.value = true;
                          },
                        ),
                        InkWell(
                          splashColor: ColorStyle.blue,
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.only(
                                bottom: 10, left: 6, right: 6),
                            decoration: BoxDecoration(
                                border: !controller.isWeeklyHours.value ? Border(
                                    bottom: BorderSide(
                                      color: ColorStyle.blue,
                                      width: 4,
                                    )) : Border(
                                    bottom: BorderSide(
                                      color: Colors.transparent,
                                      width: 4,
                                    )
                                )
                            ),
                            child: Text(
                              'Date overrides',
                              style: TextStyle(
                                color: !controller.isWeeklyHours.value ? ColorStyle.secondryBlack : ColorStyle.secondryBlack.withOpacity(0.5),
                                fontWeight: !controller.isWeeklyHours.value ? FontWeight.w600 : FontWeight.normal,
                                fontSize: 18,
                                fontFamily: 'Palatino',
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.isWeeklyHours.value = false;
                          },
                        ),
                      ],
                    ),
                  ),
                  if (controller.isWeeklyHours.value)
                    Expanded(child: WeeklyHours()),
                  if (!controller.isWeeklyHours.value)
                    Expanded(child: DateOverrides())
                ],
              ),
            );
          },
        ));
  }
}
