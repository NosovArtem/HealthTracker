import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/models/medical_record.dart';
import 'package:health_tracker/screens/add_lab_test_screen.dart';
import 'package:health_tracker/screens/main/card_lab_test.dart';

import '../helper/db_helper.dart';

class LabTest extends MedicalRecord {
  final String testName;
  final String result;

  LabTest({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.testName,
    required this.result,
  }) : super(
          id: id,
          userId: userId,
          type: RecordType.labTest,
          date: date,
          note: note,
        );

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.labTestsColumnTestName: testName,
      DatabaseHelper.labTestsColumnResult: result,
    };
  }

  factory LabTest.fromMap(Map<String, dynamic> map) {
    return LabTest(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      testName: map[DatabaseHelper.labTestsColumnTestName],
      result: map[DatabaseHelper.labTestsColumnResult],
    );
  }

  @override
  Widget getCardWidget() {
    return LabTestCardWidget(labTest: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return LabTestAddScreen(initialData: this);
  }
}
