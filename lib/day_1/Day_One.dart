// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';

class Day2 extends StatefulWidget {
  const Day2({super.key});

  @override
  State<Day2> createState() => _Day2State();
}

class _Day2State extends State<Day2> {
  Color bottonColor = Colors.green;
  String buttonText = "TextButton";
  String displayText = "Guru";
  Color elevatedColor = Colors.yellow;
  String elevatedText = "ElevatedButton";
  String displayElevation = "Flutter";

  int counter = 0;
  String img = 'https://picsum.photos/250?image=9';

  List<String> imageList = [
    'https://picsum.photos/250?image=9',
    ' https://picsum.photos/250?image=9'
  ];

  Random random = Random();

  void textButton() {
    setState(
      () {
        bottonColor = Color(Random().nextInt(0xffffffff)).withOpacity(1.0);
        buttonText = Random().nextInt(4) == 0 ? "Click Me" : "Press Me";
        displayText = Random().nextInt(4) == 0 ? "Ambition" : "Guru";
      },
    );
  }

  void elevatedButton() {
    setState(() {
      elevatedColor = Color(Random().nextInt(0xffffffff)).withOpacity(1.0);
      elevatedText = Random().nextInt(2) == 0 ? "Pressed" : "Clicked";
      displayElevation = Random().nextInt(2) == 0 ? "Hello sir " : " hii";
    });
  }

  void floatingActionButton() {
    setState(() {
      counter++;
    });
  }

  void floatingActionButton2() {
    setState(() {
      counter--;
    });
  }

  void networkImage() {
    setState(
      () {
        img = imageList[random.nextInt(imageList.length)];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Day-1",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 30,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: const [
      //     Icon(Icons.add_a_photo),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Center(
          child: Container(
            color: Colors.brown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 80,
                  child: Text(displayText),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(bottonColor),
                  ),
                  onPressed: textButton,
                  child: Text(buttonText),
                ),
                SizedBox(
                  height: 20,
                  child: Text(displayElevation),
                ),
                ElevatedButton(
                  onPressed: elevatedButton,
                  child: Text(elevatedText),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    " $counter",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: floatingActionButton,
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: floatingActionButton2,
                      child: const Icon(Icons.text_decrease),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/6.png',
                  height: 150,
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.network(img),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
