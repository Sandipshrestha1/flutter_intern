// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:phase1/Authentication/login_screen.dart';
import 'package:phase1/screens/HomeScreen/home_page_data.dart';
import 'package:phase1/screens/dash_board.dart';

import 'screens/posts/first_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(const Day7());
}

class Day7 extends StatelessWidget {
  const Day7({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socia App',
      home: //Profile(),
          Dashboard(),
      //LoginScreen(),
      //home: HomeScreen(),

      // home: FirstScreen(),
    );
  }
}
