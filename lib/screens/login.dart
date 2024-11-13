import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/app_user_model.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/screens/home.dart';
import 'package:to_do/screens/register.dart';
import 'package:to_do/themes&colors/my_colors.dart';
import 'package:to_do/widgets/log_reg_button.dart';
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
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login_bg.png"), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: fromKey,
              child: SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .504 + 44,
                    ),
                    LogTextField(
                      hint: "Enter your email",
                      controller: emailController,
                      ketBordTybe: TextInputType.emailAddress,
                      validator: (p0) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(p0!)) {
                          return 'Ivalid Email';
                        }
                        return null;
                      },
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
                            if (fromKey.currentState!.validate()) {
                              context.loaderOverlay.show();
                              await Provider.of<MyAuthProvider>(context,
                                      listen: false)
                                  .login(
                                      AppUserModel(email: emailController.text),
                                      passwordController.text)
                                  .then(
                                (value) {
                                  if (Provider.of<MyAuthProvider>(context,
                                              listen: false)
                                          .userModel !=
                                      null) {
                                    Navigator.pushReplacementNamed(
                                        context, Home.routeName);
                                  }
                                },
                              );
                              context.loaderOverlay.hide();
                            }
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
            ),
          )),
    );
  }
}
