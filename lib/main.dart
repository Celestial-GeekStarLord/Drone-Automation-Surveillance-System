import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(DASSApp());
}

class DASSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DASS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
