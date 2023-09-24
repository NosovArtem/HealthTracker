import 'package:flutter/material.dart';
import 'package:health_tracker/helper/popup_helper.dart';
import 'package:health_tracker/model/medical_record.dart';
import 'package:health_tracker/screen/add_diagnosis_screen.dart';
import 'package:health_tracker/screen/add_lab_test_screen.dart';
import 'package:health_tracker/screen/add_vaccine_screen.dart';
import 'package:health_tracker/screen/add_vital_info_screen.dart';
import 'package:intl/intl.dart';

import '../helper/db_helper.dart';
import '../main.dart';
import 'add_physical_exam_screen.dart';
import 'add_symptom_screen.dart';

class MedicalCardScreenState extends State<MedicalCardScreen> {
  final dbHelper = DatabaseHelper.instance;
  List<MedicalRecord> medicalRecords = [];
  List<MedicalRecord> filteredData = [];
  late String filterData;

  @override
  void initState() {
    super.initState();
    String? argument = ModalRoute.of(widget.context)!.settings.arguments as String?;
    filterData = argument ?? 'all';
    _loadMedicalRecords();
  }

  Future<void> _loadMedicalRecords() async {
    final records = await dbHelper.getAllRecords();
    setState(() {
      medicalRecords = _filter(records);
      medicalRecords.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  _filter(List<MedicalRecord> data) {
    return data.where((item) => item.contains(filterData)).toList();
  }

  Future<void> addMedicalRecord(MedicalRecord record) async {
    await dbHelper.insert(record);
    _loadMedicalRecords();
  }

  Future<void> updateMedicalRecord(MedicalRecord record) async {
    await dbHelper.update(record);
    _loadMedicalRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(), // Включаем прокрутку всегда
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final record = medicalRecords[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(155, 183, 123, 70),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                record.getCardWidget(),
                Row(
                  children: [
                    SizedBox(width: 35.0),
                    Text(
                      record.note.isEmpty ? "" : 'Заметка: ${record.note}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${DateFormat('yyyy-MM-dd HH:mm').format(record.date)}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              updateRecord(
                                  context, record.getEditScreenWidget());
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showConfirmationDialog(context, () {
                                _deleteRecord(record, index);
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ))
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showPopupWithButtons(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteRecord(MedicalRecord record, int index) {
    setState(() {
      dbHelper.remove(record.id);
      medicalRecords.removeAt(index);
    });
  }

  Future<void> showPopupWithButtons(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите тип записи'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            // Для того чтобы Column занимал только необходимое место
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  createRecord(context, DiagnosisAddOrEditScreen());
                },
                child: Text('Диагнозы'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createRecord(context, VaccineAddOrEditeScreen());
                },
                child: Text('Вакцина'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createRecord(context, PhysicalExamAddOrEditScreen());
                },
                child: Text('Вес / Рост'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createRecord(context, LabTestAddScreen());
                },
                child: Text('Анализы'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createRecord(context, SymptomAddOrEditeScreen());
                },
                child: Text('Симптомы'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createRecord(context, VitalInfoAddOrEditeScreen());
                },
                child: Text('Важные измерения'),
              ),
            ],
          ),
        );
      },
    );
  }

  void createRecord(BuildContext context, StatefulWidget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    ).then((map) {
      if (map != null) {
        medicalRecords.add(map["new"]);
        addMedicalRecord(map["new"]);
        setState(() {});
      }
    });
  }

  void updateRecord(BuildContext context, StatefulWidget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    ).then((map) {
      if (map != null) {
        medicalRecords.remove(map["old"]);
        medicalRecords.add(map["new"]);
        updateMedicalRecord(map["new"]);
        setState(() {});
      }
    });
  }
}
