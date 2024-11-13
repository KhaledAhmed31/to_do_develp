import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/screens/edit.dart';
import 'package:to_do/screens/home.dart';
import 'package:to_do/screens/login.dart';
import 'package:to_do/screens/register.dart';
import 'package:to_do/themes&colors/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.initialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()..getTasks()),
      ChangeNotifierProvider(create: (_) => MyAuthProvider()),
      ChangeNotifierProvider(create: (_) => themeProvider)
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
        Home.routeName: (_) => const Home(),
        Edit.routeName: (_) => const Edit(),
        Login.routeName: (_) => const Login(),
        Register.routeName: (_) => const Register(),
        Edit.routeName: (_) => const Edit()
      },
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? Login.routeName
          : Home.routeName,
      theme: (Provider.of<ThemeProvider>(context).getTheme())
          ? MyTheme.darkTheme
          : MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
    );
  }
}
