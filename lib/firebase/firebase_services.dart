import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/models/app_user_model.dart';
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

  static Future<void> delete(String id) async {
    return await collection.doc(id).delete();
  }

  static Future<List<TaskModel>> getTasks(DateTime selectedDate) async {
    QuerySnapshot<TaskModel> docs = await collection
        .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
        .get();
    return docs.docs.map((e) => e.data()).toList();
  }

  static Future<void> login(AppUserModel user, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: password);
  }

  static Future<void> register(AppUserModel user, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email!, password: password);
  }
}
