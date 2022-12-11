import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Settings> {
  final List<String> settings = <String>['앱 정보', '로그아웃', '이용약관', '개인정보 처리방침'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: settings.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: Text('hi'),
                  );
                });
          },
          child: Card(
            color: Colors.grey,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                settings[index],
                style: TextStyle(fontSize: 40),
              ),
            )),
          ),
        );
      },
    )));
  }
}
