import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

import 'package:vdfit/data/user.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://vdfit-b0eb0-default-rtdb.firebaseio.com/';

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;

  void initState() {
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database?.reference().child('user');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _idTextController,
                decoration: const InputDecoration(
                    labelText: '아이디를 입력하세요',
                    hintText: '4자 이상 입력하세요',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _pwTextController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: '비밀번호를 입력하세요',
                    hintText: '6자 이상 입력하세요',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _pwCheckTextController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: '비밀번호를 다시 입력하세요',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_idTextController!.value.text.length >= 4 &&
                        _pwTextController!.value.text.length >= 6) {
                      if (_pwTextController!.value.text ==
                          _pwCheckTextController!.value.text) {
                        var bytes = utf8.encode(_pwTextController!.value.text);
                        var digest = sha1.convert((bytes));

                        reference!
                            .child(_idTextController!.value.text)
                            .push()
                            .set(User(
                                    _idTextController!.value.text,
                                    digest.toString(),
                                    DateTime.now().toIso8601String())
                                .toJson())
                            .then((_) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        makeDialog('비밀번호가 일치하지 않습니다');
                      }
                    } else {
                      makeDialog('아이디, 비밀번호 길이를 확인해주세요');
                    }
                  },
                  child: Text('회원가입하기'))
            ],
          ),
        ),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
