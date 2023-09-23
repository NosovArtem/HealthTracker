import 'package:flutter/cupertino.dart';

import '../../models/lab_test.dart';

class LabTestCardWidget extends StatelessWidget {
  final LabTest labTest;

  LabTestCardWidget({required this.labTest});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/100/vials-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Название теста: ${labTest.testName}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/100/medical-history-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Результат: ${labTest.result}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
