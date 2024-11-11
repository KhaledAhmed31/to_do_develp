import 'package:flutter/material.dart';
import 'package:to_do/firebase/firebase_services.dart';
import 'package:to_do/models/app_user_model.dart';
import 'package:to_do/screens/register.dart';
import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/log_reg_button.dart';
import 'package:to_do/widgets/my_text_field.dart';
import 'package:to_do/widgets/text_field.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/login_bg.png"))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .504 + 74,
                ),
                LogTextField(
                  hint: "Enter your email",
                  controller: emailController,
                  ketBordTybe: TextInputType.emailAddress,
                ),
                LogTextField(
                  hint: "Enter Password",
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width - 54,
                    child: LogRegButton(
                      title: 'Login',
                      onPressed: () async {
                        await FirebaseServices.login(
                            AppUserModel(email: emailController.text),
                            passwordController.text);
                      },
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget password",
                      style: TextStyle(color: MyColors.lightBlue),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(),
                            foregroundColor: MyColors.lightBlue),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Register.routeName);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
