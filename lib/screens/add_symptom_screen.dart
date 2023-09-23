import 'package:flutter/material.dart';
import 'package:health_tracker/models/symptom.dart';

import 'date_time_screen.dart';

class SymptomAddOrEditeScreen extends StatefulWidget {
  final Symptom? initialData;

  SymptomAddOrEditeScreen({Key? key, this.initialData}) : super(key: key);

  @override
  _SymptomAddOrEditeScreenState createState() => _SymptomAddOrEditeScreenState();
}

class _SymptomAddOrEditeScreenState extends State<SymptomAddOrEditeScreen> {
  final List<String> symptoms = [];
  final TextEditingController symptomController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late DateTimePickerWidget dateTimePickerWidget;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      noteController.text = widget.initialData!.note;

      DateTime dateTime = widget.initialData?.date ?? DateTime.now();
      dateTimePickerWidget = DateTimePickerWidget(
        initialDate: dateTime,
        controllerDate: dateController,
        controllerTime: timeController,
      );
      //  todo: init symbols
    }
  }

  @override
  void dispose() {
    symptomController.dispose();
    super.dispose();
  }

  void addTag(String tag) {
    setState(() {
      symptoms.add(tag);
    });
    symptomController.clear();
  }

  void removeTag(String tag) {
    setState(() {
      symptoms.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление симптомов'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: symptomController,
              decoration: InputDecoration(labelText: 'Введите симптом'),
              onFieldSubmitted: (tag) {
                if (tag.isNotEmpty) {
                  addTag(tag);
                }
              },
            ),
            SizedBox(height: 20),
            Text('Добавленные симптомы:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: symptoms.map((tag) {
                return Chip(
                  label: Text(tag),
                  onDeleted: () {
                    removeTag(tag);
                  },
                );
              }).toList(),
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
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                // Создайте новую запись и передайте ее обратно в основной экран
                final newRecord = Symptom(
                  id: widget.initialData?.id ?? -1,
                  userId: widget.initialData?.userId ?? 1,
                  date: DateTime.now(),
                  symptoms: symptoms,
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
