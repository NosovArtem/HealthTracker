import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/model/medical_record.dart';
import 'package:health_tracker/screen/add_physical_exam_screen.dart';

import '../helper/db_helper.dart';
import '../widget/card/card_physical_exam.dart';

class PhysicalExam extends MedicalRecord {
  final String height;
  final String weight;

  PhysicalExam({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.height,
    required this.weight,
  }) : super(
          id: id,
          userId: userId,
          type: RecordType.physicalExam,
          date: date,
          note: note,
        );

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.physicalExamsColumnHeight: height,
      DatabaseHelper.physicalExamsColumnWeight: weight,
    };
  }

  factory PhysicalExam.fromMap(Map<String, dynamic> map) {
    return PhysicalExam(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      height: map[DatabaseHelper.physicalExamsColumnHeight],
      weight: map[DatabaseHelper.physicalExamsColumnWeight],
    );
  }

  @override
  Widget getCardWidget() {
    return PhysicalExamCardWidget(physicalExam: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return PhysicalExamAddOrEditScreen(initialData: this);
  }
}
