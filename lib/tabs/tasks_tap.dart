import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/task_card.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();
  late bool isDark;
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    TaskProvider provider = Provider.of<TaskProvider>(context);
    isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: EasyInfiniteDateTimeLine(
          controller: controller,
          showTimelineHeader: false,
          firstDate: DateTime(2018),
          focusDate: provider.currentDate,
          lastDate: DateTime(2028),
          onDateChange: (selectedDate) {
            setState(() {
              provider.changeDate(selectedDate);
            });
          },
          dayProps: !themeProvider.getTheme()
              ? EasyDayProps(
                  todayStyle: DayStyle(
                      monthStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayNumStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  activeDayStyle: DayStyle(
                      monthStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayNumStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: MyColors.lightBlue, width: 3),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  inactiveDayStyle: const DayStyle(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)))))
              : EasyDayProps(
                  todayStyle: DayStyle(
                      monthStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayNumStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: MyColors.lightBlack,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  activeDayStyle: DayStyle(
                      monthStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayStrStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      dayNumStyle: TextStyle(
                          color: MyColors.lightBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: MyColors.lightBlue, width: 2),
                          color: MyColors.lightBlack,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  inactiveDayStyle: DayStyle(
                      monthStrStyle:
                          TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                      dayStrStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                      dayNumStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(color: MyColors.lightBlack, borderRadius: BorderRadius.all(Radius.circular(10))))),
        ),
      ),
      Expanded(
          child: provider.tasks.isEmpty
              ? Center(
                  child: Text(
                    'No Tasks Today',
                    style: TextStyle(
                        color: MyColors.lightBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                )
              : ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) =>
                      TaskCard(taskModel: provider.tasks[index])))
    ]);
  }
}
