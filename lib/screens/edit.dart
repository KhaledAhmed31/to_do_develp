import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/tabs/tasks_tap.dart';

import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/my_text_field.dart';

class Edit extends StatefulWidget {
  static String routeName = "Edit";
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DateTime currentDate = TasksState.currentDate;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    String taskId = ModalRoute.of(context)!.settings.arguments as String;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [MyColors.lightBlue, Theme.of(context).primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [.24, .24])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            ' ',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
                  height: screenHeight * .6,
                  width: screenWidth * .85,
                  decoration: BoxDecoration(
                      color: themeProvider.getTheme()
                          ? MyColors.lightBlack
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Edit Task",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              MyTextField(
                                controller: titleController,
                                hint: "Title",
                                size: 18,
                                fontWeight: FontWeight.w700,
                                maxLines: 1,
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Enter title";
                                  }
                                  return null;
                                },
                              ),
                              MyTextField(
                                controller: descriptionController,
                                hint: "Description",
                                size: 18,
                                fontWeight: FontWeight.w400,
                                maxLines: 3,
                              ),
                              SizedBox(),
                              Text(
                                "Select the date:",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton(
                                onPressed: () async {
                                  DateTime? now = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: currentDate,
                                    currentDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );
                                  setState(() {
                                    currentDate =
                                        DateTime(now!.year, now.month, now.day);
                                  });
                                },
                                child: Text(
                                  dateFormat.format(currentDate),
                                  style: TextStyle(
                                      fontSize: 18, color: MyColors.lightBlue),
                                ),
                              ),
                              ElevatedButton(
                                style: IconButton.styleFrom(
                                    elevation: 10,
                                    foregroundColor: Colors.white,
                                    backgroundColor: MyColors.lightBlue,
                                    side: const BorderSide(
                                        color: Colors.white, width: 4)),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FirebaseServices.updateTask(
                                        TaskModel(
                                            id: taskId,
                                            title: titleController.text.trim(),
                                            description: descriptionController
                                                .text
                                                .trim(),
                                            date: DateTime(
                                                currentDate.year,
                                                currentDate.month,
                                                currentDate.day)),
                                        taskId);

                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('Save changes',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
