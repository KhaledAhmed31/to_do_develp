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
  static DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: EasyInfiniteDateTimeLine(
          controller: controller,
          showTimelineHeader: false,
          firstDate: DateTime(2018),
          focusDate: currentDate,
          lastDate: DateTime(2028),
          onDateChange: (selectedDate) {
            setState(() {
              currentDate = selectedDate;
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
      StreamBuilder(
        stream: Provider.of<TaskProvider>(context, listen: false)
            .getTasks(currentDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('=====================================');
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: MyColors.lightBlue,
                ),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  "No Tasks Today",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            );
          } else {
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        TaskCard(taskModel: snapshot.data![index])));
          }
        },
      )
    ]);
  }
}
