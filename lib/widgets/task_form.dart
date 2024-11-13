import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/my_text_field.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  DateTime currentDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context, listen: false);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Add new task",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              MyTextField(
                controller: titleController,
                hint: "Title",
                size: 20,
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
                maxLines: 5,
              ),
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
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  setState(() {
                    currentDate = DateTime(now!.year, now.month, now.day);
                  });
                },
                child: Text(
                  dateFormat.format(currentDate),
                  style: TextStyle(fontSize: 18, color: MyColors.lightBlue),
                ),
              ),
              ElevatedButton(
                  style: IconButton.styleFrom(
                      elevation: 10,
                      foregroundColor: Colors.white,
                      backgroundColor: MyColors.lightBlue,
                      side: const BorderSide(color: Colors.white, width: 4)),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      provider.addTask(TaskModel(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          date: DateTime(currentDate.year, currentDate.month,
                              currentDate.day)));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Icon(
                    Icons.done,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
