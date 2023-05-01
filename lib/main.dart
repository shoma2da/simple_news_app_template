import 'package:flutter/material.dart';
import 'app/simple_news_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const SimpleNewsApp());
}
