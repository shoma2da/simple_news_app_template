import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';

class SimpleNewsApp extends StatelessWidget {
  const SimpleNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple News App',
      home: HomeScreen(),
    );
  }
}
