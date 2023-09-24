import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/model/medical_record.dart';
import 'package:health_tracker/screen/add_symptom_screen.dart';
import 'package:health_tracker/widget/card/card_symptom.dart';

import '../helper/db_helper.dart';

class Symptom extends MedicalRecord {
  final List<String> symptoms;

  Symptom({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.symptoms,
  }) : super(
            id: id,
            userId: userId,
            type: RecordType.symptom,
            date: date,
            note: note);

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.symptomsColumnSymptom: symptoms,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map) {
    return Symptom(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      symptoms: map[DatabaseHelper.symptomsColumnSymptom],
    );
  }

  @override
  Widget getCardWidget() {
    return SymptomCardWidget(symptom: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return SymptomAddOrEditeScreen(initialData: this);
  }
}
