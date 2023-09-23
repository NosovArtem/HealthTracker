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
        Row(
          children: [
            Image.asset(
              'assets/icons/48/syringe-48.png',
              width: 28.0,
              height: 28.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Вакцина: ${vaccine.name}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
