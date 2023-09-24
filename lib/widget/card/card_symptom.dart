import 'package:flutter/cupertino.dart';

import '../../model/symptom.dart';

class SymptomCardWidget extends StatelessWidget {
  final Symptom symptom;

  SymptomCardWidget({required this.symptom});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/100/mask-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Cимптомы: ${symptom.symptoms.toString()}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
