import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.id = '',
    this.isDone = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            description: json['description'],
            date: (json['date'] as Timestamp).toDate(),
            isDone: json['isDone'],
            id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      'title': title.trim(),
      'description': description.trim(),
      'date': Timestamp.fromDate(date),
      'isDone': isDone,
      'id': id
    };
  }
}
