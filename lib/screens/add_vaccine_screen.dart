import 'package:flutter/material.dart';
import 'package:health_tracker/models/vaccine.dart';

import '../helper/time_helper.dart';
import 'date_time_screen.dart';

class VaccineAddOrEditeScreen extends StatefulWidget {
  final Vaccine? initialData;

  VaccineAddOrEditeScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _VaccineAddOrEditeScreenState createState() => _VaccineAddOrEditeScreenState();
}

class _VaccineAddOrEditeScreenState extends State<VaccineAddOrEditeScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController vaccineNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      noteController.text = widget.initialData!.note;
      vaccineNameController.text = widget.initialData!.name;

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
        title: Text('Добавить запись'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: vaccineNameController,
              decoration: InputDecoration(labelText: 'Вакцина'),
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
                final newRecord = Vaccine(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime(d.year, d.month, d.day, t.hour, t.minute),
                  note: noteController.text,
                  name: vaccineNameController.text,
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
