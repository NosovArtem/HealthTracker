import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helper/db_helper.dart';

class BackupScreen extends StatefulWidget {
  @override
  _BackupScreenState createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  final dbHelper = DatabaseHelper.instance;

  _backup() async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        dbHelper.backup(result);
      } else {
        Fluttertoast.showToast(
            msg: 'Выбор папки отменен', backgroundColor: Colors.yellow);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Ошибка: $e', backgroundColor: Colors.red);
    }
  }

  _restore() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      dbHelper.restore(file.path!);
    } else {
      Fluttertoast.showToast(
          msg: 'Выбор файла отменен', backgroundColor: Colors.yellow);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _restore,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.restore),
                            Text(
                              'Restore',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _backup,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.backup),
                            Text(
                              'Backup',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
