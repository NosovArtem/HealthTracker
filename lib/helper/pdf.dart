import 'dart:io';

import 'package:health_tracker/helper/utils.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/medical_record.dart';

Future<void> generatePDF(List<MedicalRecord> records) async {
  final destinationPath = await getInternalAppDirectory();
  if (destinationPath != null) {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyy_MM_dd_HH_mm').format(now);

    await pdf(join(destinationPath, '${formattedDateTime}.pdf'), records);
  }
}

Future<void> pdf(String fileName, List<MedicalRecord> records) async {
  final pdf = pw.Document();

  // Создайте макет для записей
  final List<pw.Widget> recordWidgets = [];
  for (var record in records) {
    recordWidgets.add(pw.Text(record.id.toString()));
    recordWidgets.add(pw.Text(record.type.name));
    recordWidgets.add(pw.Text(record.userId.toString()));
    recordWidgets.add(pw.Text(record.note));
    recordWidgets.add(pw.Text(record.date.toString()));
  }

  // Добавьте записи в PDF
  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        children: recordWidgets,
      );
    },
  ));

  // Сохраните PDF файл
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/example.pdf');
  await file.writeAsBytes(await pdf.save());

  // Откройте PDF файл
  OpenFile.open(file.path);
  // shareFile(file.path);
}
