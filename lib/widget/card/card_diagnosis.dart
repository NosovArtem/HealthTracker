import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/diagnosis.dart';

class DiagnosisCardWidget extends StatelessWidget {
  final Diagnosis diagnosis;

  DiagnosisCardWidget({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/100/medical-history-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Диагноз: ${diagnosis.name}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
