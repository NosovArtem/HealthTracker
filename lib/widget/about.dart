import 'package:flutter/material.dart';

void showAboutPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Всплывающее окно с прокруткой'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Это всплывающее окно с большим объемом текста, который можно прокручивать.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Здесь может быть много текста...',
                style: TextStyle(fontSize: 16),
              ),
              // Добавьте больше текста, если необходимо.
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Закрыть'),
          ),
        ],
      );
    },
  );
}
