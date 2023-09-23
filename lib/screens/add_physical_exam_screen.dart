import 'package:flutter/material.dart';
import 'package:health_tracker/models/physical_exam.dart';

import '../helper/time_helper.dart';
import 'date_time_screen.dart';

class PhysicalExamAddOrEditScreen extends StatefulWidget {
  final PhysicalExam? initialData;

  PhysicalExamAddOrEditScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _PhysicalExamAddOrEditScreenState createState() => _PhysicalExamAddOrEditScreenState();
}

class _PhysicalExamAddOrEditScreenState extends State<PhysicalExamAddOrEditScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      noteController.text = widget.initialData!.note;
      weightController.text = widget.initialData!.weight;
      heightController.text = widget.initialData!.height;

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
    weightController.dispose();
    heightController.dispose();
    noteController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить запись'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Вес'),
            ),
            TextFormField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Рост'),
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
                final newRecord = PhysicalExam(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime(d.year, d.month, d.day, t.hour, t.minute),
                  height: heightController.text,
                  weight: weightController.text,
                  note: noteController.text,
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
