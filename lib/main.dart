import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ordertracking/pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order Tracking',
      theme: ThemeData(
        // brightness: Brightness.dark,
        platform: TargetPlatform.iOS,
        // primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
