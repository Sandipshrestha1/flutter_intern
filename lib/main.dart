import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intern/day4/screen1.dart';

//import 'day_1/Day_One.dart';

void main() {
  runApp(const One());
}

class One extends StatelessWidget {
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: DayOne(),
      // home: Day3(),
      home: Screen1(),
    );
  }
}
