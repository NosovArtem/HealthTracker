import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context, VoidCallback callback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Подтверждение'),
        content: Text('Вы уверены, что хотите продолжить?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Действие при нажатии "Отменить"
              Navigator.of(context).pop();
            },
            child: Text('Отменить'),
          ),
          ElevatedButton(
            onPressed: () {
              // Вызываем функцию обратного вызова при нажатии "Принять"
              callback();
              Navigator.of(context).pop(); // Закрываем диалоговое окно
            },
            child: Text('Принять'),
          ),
        ],
      );
    },
  );
}



