import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final BuildContext context;

  Dropdown(this.context);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late List<String> options = [
    'all',
    'diagnosis',
    'labTest',
    'symptom',
    'vaccine',
    'vitalInfo',
    'physicalExam'
  ];

  late String selectedOption;

  @override
  void initState() {
    super.initState();
    String? argument =
        ModalRoute.of(widget.context)!.settings.arguments as String?;
    selectedOption = argument ?? 'all';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue!;
          Navigator.pushNamed(context, '/', arguments: selectedOption);
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
