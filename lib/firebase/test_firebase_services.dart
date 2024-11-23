import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/models/task_model.dart';

class TestFirebaseServices {
  CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance.collection('test').withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<void> addTask(TaskModel task) {
    CollectionReference<TaskModel> collection = getCollection();
    DocumentReference<TaskModel> doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }
}
