import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/models/app_user_model.dart';
import 'package:to_do/models/task_model.dart';

class FirebaseServices {
  static CollectionReference<TaskModel> collection = getCollection();

  //returns collection if exists else makes it first
  static CollectionReference<TaskModel> getCollection() => getUserCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('tasks')
      .withConverter(
          fromFirestore: (snapshot, options) =>
              TaskModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson());

  static CollectionReference<AppUserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              AppUserModel.fromJson(snapshot.data() ?? {}),
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

  static Future<AppUserModel> login(AppUserModel user, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email!, password: password);
    return user;
  }

  static Future<AppUserModel> register(
      AppUserModel user, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email!, password: password);
    user.id = credential.user!.uid;
    createUser(user);
    return user;
  }

  static Future<AppUserModel?> getUser() async {
    DocumentSnapshot<AppUserModel> documentSnapshot = await getUserCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return documentSnapshot.data();
  }

  static void createUser(AppUserModel user) {
    getUserCollection().doc(user.id).set(user);
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  static Future<void> updateTask(TaskModel task, String id) async {
    return await collection.doc(id).update(task.toJson());
  }
}
