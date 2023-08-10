import 'package:flutter/material.dart';
//import 'package:phase1/screens/home_page.dart';

import 'Authentication/login_screen.dart';

void main() {
  runApp(const Day7());
}

class Day7 extends StatelessWidget {
  const Day7({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Socia App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
