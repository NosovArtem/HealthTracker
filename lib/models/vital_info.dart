import 'package:flutter/src/widgets/framework.dart';
import 'package:health_tracker/models/medical_record.dart';
import 'package:health_tracker/screens/add_vital_info_screen.dart';
import 'package:health_tracker/screens/main/card_vital_info.dart';

import '../helper/db_helper.dart';

class VitalInfo extends MedicalRecord {
  final String temperature;
  final String heartPulse;
  final String bloodPressure;

  VitalInfo({
    required int id,
    required int userId,
    required DateTime date,
    required String note,
    required this.temperature,
    required this.heartPulse,
    required this.bloodPressure,
  }) : super(
          id: id,
          userId: userId,
          type: RecordType.vitalInfo,
          date: date,
          note: note,
        );

  @override
  Map<String, dynamic> toMapAdditionalPart(int recordId) {
    return {
      DatabaseHelper.recordsColumnId: recordId,
      DatabaseHelper.vitalInfoColumnTemperature: temperature,
      DatabaseHelper.vitalInfoColumnHeartPulse: heartPulse,
      DatabaseHelper.vitalInfoColumnBloodPressure: bloodPressure,
    };
  }

  factory VitalInfo.fromMap(Map<String, dynamic> map) {
    return VitalInfo(
      id: map[DatabaseHelper.recordsColumnId],
      userId: map[DatabaseHelper.recordsColumnUserId],
      date: DateTime.parse(map[DatabaseHelper.recordsColumnDate]),
      note: map[DatabaseHelper.recordsColumnNote],
      temperature: map[DatabaseHelper.vitalInfoColumnTemperature],
      heartPulse: map[DatabaseHelper.vitalInfoColumnHeartPulse],
      bloodPressure: map[DatabaseHelper.vitalInfoColumnBloodPressure],
    );
  }

  @override
  Widget getCardWidget() {
    return VitalInfoCardWidget(vitalInfo: this);
  }

  @override
  StatefulWidget getEditScreenWidget() {
    return VitalInfoAddOrEditeScreen(initialData: this);
  }
}
