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
        Row(
          children: [
            Image.asset(
              'assets/icons/100/temp-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Температура: ${vitalInfo.temperature}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/100/aed-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Пульс: ${vitalInfo.heartPulse}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/100/tonometer-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Давление: ${vitalInfo.bloodPressure}',
              style: TextStyle(fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
