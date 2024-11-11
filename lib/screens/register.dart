import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/app_user_model.dart';
import 'package:to_do/screens/login.dart';
import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/log_reg_button.dart';
import 'package:to_do/widgets/text_field.dart';

class Register extends StatefulWidget {
  static const String routeName = 'register';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/regis_bg.png"))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .37 + 84,
                ),
                LogTextField(
                  hint: "Enter your full name",
                  controller: nameController,
                  ketBordTybe: TextInputType.name,
                  validator: (p0) {
                    if (p0!.length < 3) {
                      return 'Too short';
                    }
                    return null;
                  },
                ),
                LogTextField(
                  hint: "Enter your Email",
                  controller: _emailController,
                  ketBordTybe: TextInputType.emailAddress,
                  validator: (p0) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(p0!)
                        ? 'Email is not valid'
                        : null;
                  },
                ),
                LogTextField(
                  hint: "Enter Password",
                  controller: passwordController,
                  isPassword: true,
                  validator: (p0) {
                    if (p0!.length < 9) {
                      return "Can not be less than 8 characters";
                    }
                    return null;
                  },
                ),
                LogTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  isPassword: true,
                  validator: (p0) {
                    if (p0!.length < 9 || confirmPassword()) {
                      return "Can not be less than 8 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width - 54,
                    child: LogRegButton(
                      title: 'Register',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseServices.register(
                              AppUserModel(email: _emailController.text),
                              passwordController.text);
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(),
                            foregroundColor: MyColors.lightBlue),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Login.routeName);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  bool confirmPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      return true;
    }
    return false;
  }
}
