import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:vdfit/data/user.dart';

class Login extends StatefulWidget {
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://vdfit-b0eb0-default-rtdb.firebaseio.com/';

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.videocam,
                    color: Colors.blueAccent,
                    size: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _idTextController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: '아이디를 입력하세요',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blueAccent))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _pwTextController,
                    maxLines: 1,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: '비밀번호를 입력하세요',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blueAccent))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_idTextController!.value.text.isEmpty ||
                              _pwTextController!.value.text.isEmpty) {
                            makeDiaglog('빈칸이 있습니다');
                          } else {
                            reference!
                                .child(_idTextController!.value.text)
                                .onValue
                                .listen((event) {
                              if (event.snapshot.value == null) {
                                makeDiaglog('No Id');
                              } else {
                                reference!
                                    .child(_idTextController!.value.text)
                                    .onChildAdded
                                    .listen((event) {
                                  User user = User.fromSnapShot(event.snapshot);

                                  var bytes = utf8
                                      .encode(_pwTextController!.value.text);
                                  var digest = sha1.convert(bytes);
                                  if (user.pw == digest.toString()) {
                                    Navigator.of(context).pushReplacementNamed(
                                        'mainPage',
                                        arguments:
                                            _idTextController!.value.text);
                                  } else {
                                    makeDiaglog('비밀번호가 틀립니다');
                                  }
                                });
                              }
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        child: const Text('로그인'),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('signIn');
                          },
                          child: const Text('회원가입'))
                    ],
                  )
                ],
              ),
            )));
  }

  void makeDiaglog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
