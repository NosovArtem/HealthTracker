import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> getInternalAppDirectory() async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  } catch (e) {
    print('Ошибка при получении внутренней папки: $e');
    return null;
  }
}

Future<String?> chooseDir() async {
  try {
    final String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      return directoryPath;
    } else {
      Fluttertoast.showToast(
          msg: 'Выбор папки отменен', backgroundColor: Colors.yellow);
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Ошибка: $e', backgroundColor: Colors.red);
    return null;
  }
}

Future<String?> chooseFile() async {
  try {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.first.path;
      return filePath;
    } else {
      Fluttertoast.showToast(
          msg: 'Выбор файла отменен', backgroundColor: Colors.yellow);
      return null;
    }
  } catch (e) {
    Fluttertoast.showToast(
        msg: 'Ошибка выбора файла:: $e', backgroundColor: Colors.red);
    return null;
  }
}
