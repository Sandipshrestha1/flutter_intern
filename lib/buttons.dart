// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     const Day2(),
//   );
// }

// class Day2 extends StatefulWidget {
//   const Day2({super.key});

//   @override
//   State<Day2> createState() => _Day2State();
// }

// class _Day2State extends State<Day2> {
//   Color buttonColor = Colors.green;
//   Color elevatedButtonColor = Colors.red;
//   // FontWeight textWeight = FontWeight.normal;
//   String buttonText = "TextButton";
//   String displayText = "Guru";
//   int counter = 0;

//   //List defined for Icon image
//   List<IconData> icons = [
//     Icons.home,
//     Icons.star,
//     Icons.favorite,
//     Icons.music_note,
//     Icons.camera,
//     Icons.bookmark,
//   ];
//   //***Icon image list close********** */

//   Random random = Random();
//   late IconData currentIcon;

//   void textButton() {
//     setState(
//       () {
//         buttonText = Random().nextInt(2) == 0 ? "Click again!" : "Press me!";
//         // textWeight = Random().nextBool() ? FontWeight.bold : FontWeight.normal;
//         displayText = Random().nextInt(2) == 0 ? "Ambition" : "Guru!";
//         buttonColor = Color(Random().nextInt(0xffffffff)).withOpacity(0.5);
//       },
//     );
//   }

//   void elevatedButton() {
//     setState(
//       () {
//         elevatedButtonColor =
//             Color(Random().nextInt(0xffffffff)).withOpacity(1.0);

//         // iconData = Random().nextBool() ? Icons.image : Icons.photo;
//         // imageURL = Random().nextBool()
//         //     ? "https://"
//         //     : "https://";
//       },
//     );
//   }

//   void floatingActionButton() {
//     setState(() {
//       counter++;
//     });
//   }

//   void floatingActionButton2() {
//     setState(() {
//       counter--;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     currentIcon = icons[random.nextInt(icons.length)];
//   }

//   void changeIcon() {
//     setState(
//       () {
//         currentIcon = icons[random.nextInt(icons.length)];
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Day-ii"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10.0),
//               Text(displayText),

//               //Text Button
//               TextButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(buttonColor),
//                 ),
//                 onPressed: textButton,
//                 child: Text(
//                   buttonText,
//                 ),
//               ),
//               //TextButton

//               //Elevated button start
//               const SizedBox(height: 20.0),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(elevatedButtonColor),
//                 ),
//                 onPressed: elevatedButton,
//                 child: const Text("Elevated Button"),
//               ),
//               //****elevated Button end **************/

//               const SizedBox(height: 20.0),
//               Text(
//                 "Counter: $counter",
//                 style: const TextStyle(fontSize: 20.0),
//               ),

//               //floating button start
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: floatingActionButton,
//                     child: const Icon(Icons.add),
//                   ),
//                   FloatingActionButton(
//                     onPressed: floatingActionButton2,
//                     child: const Text("--"),
//                   ),
//                 ],
//               ),
//               //******Floating button end *********/

//               const SizedBox(height: 20.0),
//               IconButton(
//                 onPressed: changeIcon,
//                 icon: Icon(currentIcon),
//               ),
//               /**Icon******/

//               //assets image
//               const SizedBox(
//                 height: 2,
//               ),
//               Image.asset('assets/images/red.png', width: 100, height: 100),
// /*******asset image *********/

// //Network image
//               // Image.network(
//               //   'https://flutter.dev/images/flutter-logo.png',
//               // )
// /**** Network image **********/
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }