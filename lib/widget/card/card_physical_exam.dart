import 'package:flutter/cupertino.dart';

import '../../model/physical_exam.dart';

class PhysicalExamCardWidget extends StatelessWidget {
  final PhysicalExam physicalExam;

  PhysicalExamCardWidget({required this.physicalExam});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/100/height-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Рост: ${physicalExam.height}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/100/weight-pound-100.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Вес: ${physicalExam.weight}',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ],
    );
  }
}
