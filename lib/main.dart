import 'package:flutter/material.dart';
import 'perpus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Perpus()
        );
  }
}
