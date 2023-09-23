import 'package:flutter/material.dart';
import 'package:health_tracker/screens/main/main_medical_card_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicalCardScreen(),
    );
  }
}

class MedicalCardScreen extends StatefulWidget {
  @override
  MedicalCardScreenState createState() => MedicalCardScreenState();
}
