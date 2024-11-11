import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/screens/edit.dart';
import 'package:to_do/screens/home.dart';
import 'package:to_do/screens/login.dart';
import 'package:to_do/screens/register.dart';
import 'package:to_do/themes&colors/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()..getTasks())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      routes: {
        Home.routeName: (context) => const Home(),
        Edit.routeName: (context) => const Edit(),
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const Register()
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: Register.routeName,
    );
  }
}
