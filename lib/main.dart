import 'package:flutter/material.dart';
import 'feedback.dart';
import 'login.dart';
import 'mainPage.dart';
import 'signIn.dart';
import 'myFeedback.dart';
import 'experts.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
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
