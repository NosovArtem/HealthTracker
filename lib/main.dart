import 'package:flutter/material.dart';
import 'package:health_tracker/screen/backup_screen.dart';
import 'package:health_tracker/screen/medical_card_screen.dart';
import 'package:health_tracker/widget/dropdown.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/backup': (context) => BackupScreen(),
      },
      home: Home(),
    ));

class Home extends StatelessWidget {
  Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'UserName',
              style: TextStyle(fontSize: 20.0),
            ),
            Dropdown(context),
            IconButton(
              onPressed: () {
                // Действие при нажатии кнопки
              },
              icon: Icon(Icons.picture_as_pdf_outlined),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text(
                'UserName',
                style: TextStyle(fontSize: 22),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/', arguments: 'all');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.backup),
              title: Text('Backup/Restore'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/backup');
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Center(
        child: MedicalCardScreen(context),
      ),
    );
  }
}

class MedicalCardScreen extends StatefulWidget {
  final BuildContext context;

  MedicalCardScreen(this.context);

  @override
  MedicalCardScreenState createState() => MedicalCardScreenState();
}
