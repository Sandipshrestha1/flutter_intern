import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Day-ii"),
          centerTitle: true,
        ),
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Day2(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Day2 extends StatefulWidget {
  const Day2({Key? key}) : super(key: key);

  @override
  State<Day2> createState() => _Day2State();
}

class _Day2State extends State<Day2> {
  Color buttonColor = Colors.green;
  Color elevatedButtonColor = Colors.red;
  String buttonText = "TextButton";
  String displayText = "Guru";
  int counter = 0;
  String img = 'https://picsum.photos/250?image=9';
  List<IconData> icons = [
    Icons.home,
    Icons.star,
    Icons.favorite,
    Icons.music_note,
    Icons.camera,
    Icons.bookmark,
  ];
  List<String> imageList = [
    'https://picsum.photos/250?image=9',
    ' https://picsum.photos/250?image=9'
  ];

  Random random = Random();
  late IconData currentIcon;

  void textButton() {
    setState(
      () {
        buttonText = Random().nextInt(2) == 0 ? "Click again!" : "Press me!";
        displayText = Random().nextInt(2) == 0 ? "Ambition" : "Guru!";
        buttonColor = Color(Random().nextInt(0xffffffff)).withOpacity(0.5);
      },
    );
  }

  void elevatedButton() {
    setState(
      () {
        elevatedButtonColor =
            Color(Random().nextInt(0xffffffff)).withOpacity(1.0);
      },
    );
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

  @override
  void initState() {
    super.initState();
    currentIcon = icons[random.nextInt(icons.length)];
  }

  void changeIcon() {
    setState(
      () {
        currentIcon = icons[random.nextInt(icons.length)];
      },
    );
  }

  void networkImage1() {
    setState(
      () {
        img = imageList[random.nextInt(imageList.length)];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        Text(displayText),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
          onPressed: textButton,
          child: Text(buttonText),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(elevatedButtonColor),
          ),
          onPressed: elevatedButton,
          child: const Text("Elevated Button"),
        ),
        const SizedBox(height: 20.0),
        Text(
          "Counter: $counter",
          style: const TextStyle(fontSize: 20.0),
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
              child: const Text("--"),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        IconButton(
          onPressed: () {
            changeIcon();
            networkImage1();
          },
          icon: Icon(currentIcon),
        ),
        const SizedBox(
          height: 2,
        ),
        Image.asset('assets/images/red.png', width: 100, height: 100),
        Image.network(img)
      ],
    );
  }
}
