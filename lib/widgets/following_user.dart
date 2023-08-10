// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// import '../model/user_details.dart';

// class FollowingUser extends StatelessWidget {
//   const FollowingUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Text(
//             "Follownig",
//             style: TextStyle(
//                 fontSize: 25, fontWeight: FontWeight.w600, letterSpacing: 2.0),
//           ),
//         ),
//         Container(
//           height: 100,
//           color: Colors.red,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: users.length,
//             itemBuilder: (BuildContext context, int index) {
//               User user = Users[index];
//               return _buildUserStory(user);
//             },

//             //  itemCount: ,

//             //itemBuilder: ,
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget _buildUserStory(User user) {
//   return Container(
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(width: 2.0, color: Colors.blue),
//           boxShadow: const [
//             BoxShadow(
//                 color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0),
//           ]),
//       child: ClipOval(
//         child: Image(
//           height: 60,
//           width: 60,
//           image: AssetImage("assets/img/img1.jpg"),
//           fit: BoxFit.cover,
//         ),
//       ));
// }
// import 'package:flutter/material.dart';
// import '../constants/users1.dart';
// import '../model/user_details.dart'; // Import your User and Users model

// class FollowingUser extends StatelessWidget {
//   const FollowingUser({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var users =
//         Users.getUsers(); // Replace with the appropriate way to get users
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Text(
//             "Following",
//             style: TextStyle(
//               fontSize: 25,
    //          fontWeight: FontWeight.w600,
  //             letterSpacing: 2.0,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         height: 100,
  //         color: Colors.red,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: users.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             User user = users[index];
  //             return _buildUserStory(user);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
//}

// Widget _buildUserStory(User user) {
//   return Container(
//     margin: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       border: Border.all(width: 2.0, color: Colors.blue),
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.black26,
//           offset: Offset(0, 2),
//           blurRadius: 6.0,
//         ),
//       ],
//     ),
//     child: const ClipOval(
//       child: Image(
//         height: 60,
//         width: 60,
//         image: AssetImage("assets / img / img1.jpg"), // Use user.imagePath
//         fit: BoxFit.cover,
//       ),
//     ),
//   );
// }
