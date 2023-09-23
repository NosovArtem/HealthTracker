import 'package:flutter/cupertino.dart';

import '../../models/symptom.dart';

class SymptomCardWidget extends StatelessWidget {
  final Symptom symptom;

  SymptomCardWidget({required this.symptom});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cимптомы: ${symptom.symptoms.toString()}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}