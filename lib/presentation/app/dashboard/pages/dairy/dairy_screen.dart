import 'package:flutter/material.dart';

class DairyScreen extends StatefulWidget {
  const DairyScreen({super.key});

  @override
  State<DairyScreen> createState() => _DairyScreenState();
}

class _DairyScreenState extends State<DairyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("dairy"),
      ),
    );
  }
}
