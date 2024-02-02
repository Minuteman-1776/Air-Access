import 'package:flutter/material.dart';

void main() {
  runApp(DebugMode());
}

class DebugMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white, Colors.white10],
              stops: [0.0, 0.3, 0.3],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
