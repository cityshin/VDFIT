import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'feedback.dart';
import 'login.dart';
import 'mainPage.dart';
import 'signIn.dart';
import 'myFeedback.dart';
import 'experts.dart';
import 'settings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        initialRoute: 'login',
        routes: {
          'login': (context) => Login(),
          'mainPage': (context) => MainPage(),
          'signIn': (context) => SignIn(),
          'feedback': (context) => getFeedback(),
          'myFeedback': (context) => MyFeedback(),
          'experts': (context) => Experts(),
          'settings': (context) => Settings(),
        });
  }
}
