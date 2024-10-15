import 'package:flutter/material.dart';
import 'screen/home.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Transações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), 
    );
  }
}
