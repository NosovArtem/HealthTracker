import 'package:flutter/cupertino.dart';

import '../../models/vital_info.dart';

class VitalInfoCardWidget extends StatelessWidget {
  final VitalInfo vitalInfo;

  VitalInfoCardWidget({required this.vitalInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Температура: ${vitalInfo.temperature}',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          'Пульс: ${vitalInfo.heartPulse}',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          'Давление: ${vitalInfo.bloodPressure}',
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}