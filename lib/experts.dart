import 'package:flutter/material.dart';

class Experts extends StatefulWidget {
  State<StatefulWidget> createState() => _Experts();
}

class _Experts extends State<Experts> {
  final List<String> experts = <String>['kim', 'lee', 'park', 'jung'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: experts.length,
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
            child: Center(
              child: Text(
                experts[index],
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
        );
      },
    );
  }
}
