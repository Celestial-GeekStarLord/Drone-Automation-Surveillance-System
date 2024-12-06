import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() {
  runApp(DASS());
}

class DASS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DASS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
