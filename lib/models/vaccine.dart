import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/models/medical_record.dart';
import 'package:health_tracker/screens/add_vaccine_screen.dart';
import 'package:health_tracker/screens/main/card_vaccine.dart';

import '../helper/db_helper.dart';

class Vaccine extends MedicalRecord {
  final String name;

  Vaccine({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.name,
  }) : super(
          id: id,
          userId: userId,
          type: RecordType.vaccine,
          date: date,
          note: note,
        );

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.vaccinesColumnName: name,
    };
  }

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      name: map[DatabaseHelper.vaccinesColumnName],
    );
  }

  @override
  Widget getCardWidget() {
    return VaccineCardWidget(vaccine: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return VaccineAddOrEditeScreen(initialData: this);
  }
}
