// import 'package:flutter/material.dart';
// import 'package:phase1/screens/post.dart';

// import 'add_post.dart';

// //import '../widgets/login_signup.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                       "https://www.shutterstock.com/image-illustration/peace-symbol-made-common-metal-600w-2161222931.jpg",
//                     ),
//                   ),
//                   // const SizedBox(width: 20),
//                   // Expanded(
//                   //   child: GestureDetector(
//                   //     child: TextFormField(
//                   //       decoration: InputDecoration(
//                   //           hintText: "Share your idea and picture here",
//                   //           border: OutlineInputBorder(
//                   //               borderRadius: BorderRadius.circular(20))),
//                   //     ),
//                   //   ),
//                   // ),

//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const AddPost()),
//                           );
//                         },
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.lightBlue[100],
//                           padding: EdgeInsets.all(26),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: const Text("Whats on your mind")),
//                   ),
//                   const SizedBox(
//                     width: 9,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const AddPost()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.red[800],
//                       backgroundColor: Colors.black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12.0, horizontal: 16.0),
//                       elevation: 10.0,
//                     ),
//                     child: const Text("Post "),
//                   )
//                 ],
//               ),
//               Post(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:phase1/screens/post.dart';
import 'add_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              UserInfoRow(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: const [
                    Post(),
                    // Add more Post widgets here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://www.shutterstock.com/image-illustration/peace-symbol-made-common-metal-600w-2161222931.jpg",
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPost()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue[100],
              padding: const EdgeInsets.all(26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("What's on your mind"),
          ),
        ),
      ],
    );
  }
}
