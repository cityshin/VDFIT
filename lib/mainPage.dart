import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                color: Color(0xff33CCFF),

          child:TextButton(


                onPressed: () {
                  Navigator.of(context).pushNamed('feedback');
                },

                child: const Text(
                  '피드백 받기',
                  style: TextStyle(fontSize: 60, color: Colors.black),
                ),
              ),
              ),
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('myFeedback');
                    },

                    child: const Text('나의 피드백',
                        style: TextStyle(fontSize: 60, color: Colors.black)),
                  ))),

              Expanded(
                child: Container(
                    width: double.infinity,
                    color: Colors.blueAccent,
                    child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('experts');
                },

                child: const Text('전문가들',
                    style: TextStyle(fontSize: 60, color: Colors.black)),
              ))),
              Expanded(
                child: Container(
                    width: double.infinity,
                    color: Colors.grey,
                    child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('settings');
                },

                child: const Text('설정',
                    style: TextStyle(fontSize: 60, color: Colors.black)),
              ))),


            ],
          ),
        ));
  }
}
