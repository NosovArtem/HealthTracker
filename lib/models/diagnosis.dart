import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/models/medical_record.dart';
import 'package:health_tracker/screens/add_diagnosis_screen.dart';

import '../helper/db_helper.dart';
import '../screens/main/card_diagnosis.dart';

class Diagnosis extends MedicalRecord {
  final String name;

  Diagnosis({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.name,
  }) : super(
          id: id,
          userId: userId,
          type: RecordType.diagnosis,
          date: date,
          note: note,
        );

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      name: map[DatabaseHelper.diagnosisColumnName],
    );
  }

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.diagnosisColumnName: name,
    };
  }

  @override
  Widget getCardWidget() {
    return DiagnosisCardWidget(diagnosis: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return DiagnosisAddOrEditScreen(initialData: this);
  }
}
