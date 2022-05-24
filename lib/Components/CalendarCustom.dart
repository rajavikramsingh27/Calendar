
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Controllers/DateOverridesControllers.dart';
import 'package:get/get.dart';
import '../Styles/ColorStyle.dart';

class CalendarCustom extends StatefulWidget {
  final Function(DateTime)? onDaySelected;

  CalendarCustom({Key? key, required this.onDaySelected}) : super(key: key);

  @override
  _CalendarCustomState createState() => _CalendarCustomState();
}

class _CalendarCustomState extends State<CalendarCustom> {
  late final PageController _pageController;

  final styleText = TextStyle(
      fontSize: 15, fontFamily: 'Palatino', fontWeight: FontWeight.normal);

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  DateTime kFirstDay = DateTime(DateTime.now().year - 30, DateTime.now().month, DateTime.now().day);
  DateTime kLastDay = DateTime(DateTime.now().year + 30, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(
          style: styleText,
          focusedDay: this.focusedDay,
          onTodayButtonTap: () {
            this.focusedDay = DateTime.now();

            setState(() {

            });
          },
          onLeftArrowTap: () {
            this._pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          onRightArrowTap: () {
            this._pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
        ),
        TableCalendar(
          firstDay: this.kFirstDay,
          lastDay: this.kLastDay,
          focusedDay: this.focusedDay,
          calendarFormat: this.calendarFormat,
          headerVisible: false,
          // headerStyle: HeaderStyle(
          //     titleTextStyle:
          //     styleText.apply(fontSizeDelta: 5, fontWeightDelta: 3),
          //     formatButtonTextStyle: styleText,
          //     headerPadding: EdgeInsets.only(top: 0, bottom: 0),
          //     headerMargin: EdgeInsets.only(
          //       bottom: 16,
          //     ),
          //     formatButtonVisible: false,
          //     leftChevronIcon: Icon(
          //       Icons.chevron_left,
          //       size: 30,
          //       color: ColorStyle.blue,
          //     ),
          //     rightChevronIcon: Icon(
          //       Icons.chevron_right,
          //       size: 30,
          //       color: ColorStyle.blue,
          //     ),
          //     leftChevronMargin: EdgeInsets.only(
          //       left: 0,
          //       right: 0,
          //       bottom: 0,
          //       top: 0,
          //     ),
          //     rightChevronMargin: EdgeInsets.only(
          //       left: 0,
          //       right: 0,
          //       bottom: 0,
          //       top: 0,
          //     ),
          //     decoration: BoxDecoration(
          //         border: Border(
          //             bottom:
          //             BorderSide(color: Colors.grey, width: 1)))),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: styleText,
            weekendStyle: styleText,
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: styleText.apply(),
            todayDecoration: BoxDecoration(
              color: Colors.green,
              // borderRadius: BorderRadius.circular(60),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: ColorStyle.blue,
              // borderRadius: BorderRadius.circular(60),
              shape: BoxShape.circle,
            ),
            selectedTextStyle:
            styleText.apply(color: ColorStyle.primaryWhite),
            disabledTextStyle: styleText.apply(color: Colors.grey),
            outsideTextStyle: styleText.apply(color: Colors.grey),
            todayTextStyle: styleText.apply(color: Colors.white),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(this.selectedDay, day);
          },
          onCalendarCreated: (controller) =>
          _pageController = controller,
          onDaySelected: (selectedDay, focusedDay) {

            widget.onDaySelected!(focusedDay);

            if (!isSameDay(this.selectedDay, selectedDay)) {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay;
            }

            setState(() {

            });
          },
          onPageChanged: (focusedDay) {
            this.focusedDay = focusedDay;

            setState(() {

            });
          },
        ),
      ],
    );
  }
}

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final TextStyle style;

  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Container(
      padding: EdgeInsets.only(
        bottom: 0, top: 0,
      ),
      margin: EdgeInsets.only(
          bottom: 16
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey,
                  width: 1
              )
          )
      ),
      child: Row(
        children: [
          SizedBox(width: 16.0),
          Text(
            headerText,
            style: style.apply(fontSizeDelta: 5, fontWeightDelta: 3),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: ColorStyle.blue,
            ),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              size: 30,
              color: ColorStyle.blue,
            ),
            onPressed: onRightArrowTap,
          ),
          TextButton(
            child: Text(
              'Today',
              style: style.apply(
                  color: Colors.grey,
                  fontWeightDelta: 1
              ),
            ),
            onPressed: onTodayButtonTap,
          ),
          SizedBox(width: 16.0),
        ],
      ),
    );
  }
}