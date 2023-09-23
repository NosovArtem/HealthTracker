import 'package:flutter/cupertino.dart';

import '../../models/diagnosis.dart';

class DiagnosisCardWidget extends StatelessWidget {
  final Diagnosis diagnosis;

  DiagnosisCardWidget({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Диагноз: ${diagnosis.name}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}