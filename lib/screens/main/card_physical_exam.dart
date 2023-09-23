import 'package:flutter/cupertino.dart';

import '../../models/physical_exam.dart';

class PhysicalExamCardWidget extends StatelessWidget {
  final PhysicalExam physicalExam;

  PhysicalExamCardWidget({required this.physicalExam});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Рост: ${physicalExam.height}',
          style: TextStyle(fontSize: 14),
        ),
        Text(
          'Вес: ${physicalExam.weight}',
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}