import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class getFeedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _getFeedback();
}

class _getFeedback extends State<getFeedback> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영상 선택'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (pickedFile != null)
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Center(
                  child: Text(pickedFile!.name),
                ),
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: selectFile, child: const Text('파일 선택')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: uploadFile,
            child: const Text('파일 전송'),
          ),
          const SizedBox(
            height: 30,
          ),
          buildProgress(),
        ],
      )),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['mp4']);
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ));
        } else {
          return SizedBox(
            height: 50,
          );
        }
      });

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Downlioad Link: $urlDownload');
    setState(() {
      uploadTask = null;
    });
    Dialog();
   // Navigator.of(context).pop();
  }

  void Dialog() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children:[
                Text('전송 완료')
              ]
            ),
            content: Column(
              children: [
                Text('감사합니다!',)
              ],
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('mainPage');
                  },
                  child: new Text('확인'))
            ],
          );
        });
  }
}
