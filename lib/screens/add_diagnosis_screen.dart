import 'package:flutter/material.dart';
import 'package:health_tracker/models/diagnosis.dart';

import '../helper/time_helper.dart';
import 'date_time_screen.dart';

class DiagnosisAddOrEditScreen extends StatefulWidget {
  final Diagnosis? initialData;

  DiagnosisAddOrEditScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _DiagnosisAddOrEditScreenState createState() =>
      _DiagnosisAddOrEditScreenState();
}

class _DiagnosisAddOrEditScreenState extends State<DiagnosisAddOrEditScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    noteController.text = widget.initialData?.note ?? '';
    diagnosisController.text = widget.initialData?.name ?? '';

    DateTime dateTime = widget.initialData?.date ?? DateTime.now();
    dateTimePickerWidget = DateTimePickerWidget(
      initialDate: dateTime,
      controllerDate: dateController,
      controllerTime: timeController,
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialData != null
            ? 'Редактировать запись'
            : 'Добавить запись'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: diagnosisController,
              decoration: InputDecoration(labelText: 'Диагноз'),
            ),
            dateTimePickerWidget,
            TextFormField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Заметка'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Создайте новую запись и передайте ее обратно в основной экран
                DateTime d = DateTime.parse(dateController.text);
                TimeOfDay t = parseTimeOfDay(timeController.text);
                final newRecord = Diagnosis(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime(d.year, d.month, d.day, t.hour, t.minute),
                  note: noteController.text,
                  name: diagnosisController.text,
                );
                Navigator.pop(context, {"old": widget.initialData, "new": newRecord});
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
