import 'package:flutter/cupertino.dart';

import '../../models/vaccine.dart';

class VaccineCardWidget extends StatelessWidget {
  final Vaccine vaccine;

  VaccineCardWidget({required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Вакцина: ${vaccine.name}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}