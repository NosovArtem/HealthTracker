import 'package:flutter/material.dart';
import 'package:health_tracker/model/vital_info.dart';

import '../helper/time_helper.dart';
import '../widget/date_time.dart';

class VitalInfoAddOrEditeScreen extends StatefulWidget {
  final VitalInfo? initialData;

  VitalInfoAddOrEditeScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _VitalInfoAddOrEditeScreenState createState() => _VitalInfoAddOrEditeScreenState();
}

class _VitalInfoAddOrEditeScreenState extends State<VitalInfoAddOrEditeScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController heartPulseController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      noteController.text = widget.initialData!.note;
      temperatureController.text = widget.initialData!.temperature;
      heartPulseController.text = widget.initialData!.heartPulse;
      bloodPressureController.text = widget.initialData!.bloodPressure;

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
              controller: temperatureController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Температура'),
            ),
            TextFormField(
              controller: heartPulseController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Пульс'),
            ),
            TextFormField(
              controller: bloodPressureController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Давление'),
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
                final newRecord = VitalInfo(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime(d.year, d.month, d.day, t.hour, t.minute),
                  note: noteController.text,
                  bloodPressure: bloodPressureController.text,
                  heartPulse: heartPulseController.text,
                  temperature: temperatureController.text,
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
