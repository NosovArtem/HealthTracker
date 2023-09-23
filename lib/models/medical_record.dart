import 'package:flutter/cupertino.dart';
import 'package:health_tracker/helper/db_helper.dart';
import 'package:health_tracker/models/physical_exam.dart';
import 'package:health_tracker/models/symptom.dart';
import 'package:health_tracker/models/vaccine.dart';
import 'package:health_tracker/models/vital_info.dart';

import 'diagnosis.dart';
import 'lab_test.dart';

enum RecordType {
  diagnosis,
  labTest,
  symptom,
  vaccine,
  vitalInfo,
  physicalExam
}

abstract class MedicalRecord {
  final int id;
  final int userId;
  final RecordType type;
  final DateTime date;
  final String note;

  MedicalRecord({
    required this.id,
    required this.userId,
    required this.type,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMapAdditionalPart(int recordId);

  Map<String, dynamic> toMapBaseRecord({int? id}) {
    final baseRecordMap = {
      DatabaseHelper.recordsColumnUserId: userId,
      DatabaseHelper.recordsColumnType: type.name,
      DatabaseHelper.recordsColumnDate: date.toIso8601String(),
      DatabaseHelper.recordsColumnNote: note,
    };

    if (id != null) {
      baseRecordMap[DatabaseHelper.recordsColumnId] = id;
    }

    return baseRecordMap;
  }


  factory MedicalRecord.fromMap(Map<String, dynamic> map) {
    final String recordType = map['type'];

    switch (recordType) {
      case 'diagnosis':
        return Diagnosis.fromMap(map);
      case 'labTest':
        return LabTest.fromMap(map);
      case 'symptom':
        return Symptom.fromMap(map);
      case 'vaccine':
        return Vaccine.fromMap(map);
      case 'vitalInfo':
        return VitalInfo.fromMap(map);
      case 'physicalExam':
        return PhysicalExam.fromMap(map);
      default:
        throw ArgumentError('Неизвестный тип записи: $recordType');
    }
  }


  Widget getCardWidget();
  StatefulWidget getEditScreenWidget();

}
