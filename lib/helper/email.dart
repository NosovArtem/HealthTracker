import 'package:url_launcher/url_launcher.dart';

Future<void> sendEmail(String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'tatatansv@gmail.com',
    queryParameters: {'subject': 'Тема сообщения', 'body': body},
  );

  if (await canLaunch(emailUri.toString())) {
    await launch(emailUri.toString());
  } else {
    print('Не удалось отправить электронное письмо');
  }
}



Future<void> sendApp() async {
  final String appUrl = 'https://apps.apple.com/us/app/your-app-name/id1234567890'; // Замените на URL вашего приложения в App Store
  if (await canLaunch(appUrl)) {
    await launch(appUrl);
  } else {
    print('Не удалось открыть ссылку');
  }
}
