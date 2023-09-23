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
        Text(
          'Название теста: ${labTest.testName}',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          'Результат: ${labTest.result}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}