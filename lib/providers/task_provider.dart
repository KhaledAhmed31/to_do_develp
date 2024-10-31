import 'package:flutter/material.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime currentDate = DateTime.now();

  Future<void> getTasks() async {
    tasks = await FirebaseServices.getTasks(
        DateTime(currentDate.year, currentDate.month, currentDate.day));
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await FirebaseServices.addTask(task);
    getTasks();
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await FirebaseServices.delete(id);
    getTasks();
  }

  void changeDate(DateTime newDate) {
    currentDate = newDate;
    getTasks();
    notifyListeners();
  }
}
