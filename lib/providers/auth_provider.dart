import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/app_user_model.dart';

class MyAuthProvider extends ChangeNotifier {
  AppUserModel? userModel;
  Future<void> login(AppUserModel user, String password) async {
    try {
      userModel = await FirebaseServices.login(user, password);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: const Color.fromARGB(255, 173, 39, 30),
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    }
  }

  Future<void> register(AppUserModel user, String password) async {
    try {
      userModel = await FirebaseServices.register(user, password);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: const Color.fromARGB(255, 173, 39, 30),
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white);
    }
  }
}
