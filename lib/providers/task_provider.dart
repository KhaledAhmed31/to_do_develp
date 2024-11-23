import 'package:flutter/material.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  Stream<List<TaskModel>> getTasks(DateTime currentDate) async* {
    Stream<List<TaskModel>> tasks = FirebaseServices.getTasks(
        DateTime(currentDate.year, currentDate.month, currentDate.day));
    notifyListeners();
    yield* tasks;
  }

  Future<void> addTask(TaskModel task) async {
    await FirebaseServices.addTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await FirebaseServices.delete(id);
  }
}
