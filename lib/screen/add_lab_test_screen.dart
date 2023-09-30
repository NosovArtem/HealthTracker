import 'package:flutter/material.dart';
import 'package:health_tracker/model/lab_test.dart';

import '../helper/time_helper.dart';
import '../widget/date_time.dart';

class LabTestAddScreen extends StatefulWidget {
  final LabTest? initialData;

  LabTestAddScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _LabTestAddOrEditeScreenState createState() => _LabTestAddOrEditeScreenState();
}

class _LabTestAddOrEditeScreenState extends State<LabTestAddScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final TextEditingController testNameController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      noteController.text = widget.initialData!.note;
      testNameController.text = widget.initialData!.testName;
      resultController.text = widget.initialData!.result;

      DateTime dateTime = widget.initialData?.date ?? DateTime.now();
      dateTimePickerWidget = DateTimePickerWidget(
        initialDate: dateTime,
        controllerDate: dateController,
        controllerTime: timeController,
      );
    }
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
              controller: testNameController,
              decoration: InputDecoration(labelText: 'Название теста'),
            ),
            TextFormField(
              controller: resultController,
              decoration: InputDecoration(labelText: 'Результат'),
            ),
            DateTimePickerWidget(
              initialDate: DateTime.now(),
              controllerDate: dateController,
              controllerTime: timeController,
            ),
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
                final newRecord = LabTest(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime(d.year, d.month, d.day, t.hour, t.minute),
                  note: noteController.text,
                  result: resultController.text,
                  testName: testNameController.text,
                );
                Navigator.pop(context, {"old": widget.initialData, "new": newRecord});
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
