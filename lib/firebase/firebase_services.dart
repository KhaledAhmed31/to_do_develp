import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/models/task_model.dart';

class FirebaseServices {
  static CollectionReference<TaskModel> collection = getCollection();

  //returns collection if exists else makes it first
  static CollectionReference<TaskModel> getCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson());

  static Future<void> addTask(TaskModel task) {
    DocumentReference<TaskModel> doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<void> delete(String id) {
    return collection.doc(id).delete();
  }

  static Future<List<TaskModel>> getTasks(DateTime selectedDate) async {
    QuerySnapshot<TaskModel> docs = await collection
        .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
        .get();
    return docs.docs.map((e) => e.data()).toList();
  }
}
