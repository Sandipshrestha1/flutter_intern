// import 'package:flutter/material.dart';

// class Post extends StatefulWidget {
//   const Post({Key? key});

//   @override
//   State<Post> createState() => _PostState();
// }

// class _PostState extends State<Post> {
//   bool _isLiked = false; // Added a variable to track the like status
//   int _likeCount = 100;

//   void _toggleLike() {
//     setState(() {
//       _isLiked = !_isLiked;
//       _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               BuildPostFirstRow(),
//               Icon(Icons.more_vert),
//             ],
//           ),
//           const SizedBox(height: 10),
//           BuildPostPicture(onLike: _toggleLike, isLiked: _isLiked),
//           const SizedBox(height: 5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Text(
//                   "$_likeCount Likes",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BuildPostFirstRow extends StatelessWidget {
//   const BuildPostFirstRow({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         CircleAvatar(
//           radius: 25,
//           backgroundImage: NetworkImage(
//               "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_Nepal.svg/640px-Flag_of_Nepal.svg.png"),
//         ),
//         SizedBox(width: 5),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Sandip",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class BuildPostPicture extends StatelessWidget {
//   final VoidCallback onLike;
//   final bool isLiked;

//   const BuildPostPicture(
//       {Key? key, required this.onLike, required this.isLiked});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.width - 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//             image: const DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(
//                   "https://www.nepalhikingteam.com/_next/image?url=https%3A%2F%2Fnht-api.nepalhikingteam.com%2Fmedia%2Fblog%2Fbanner%2F7-best-short-treks-in-nepal.jpg&w=3840&q=75"),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: IconButton(
//             icon: Icon(Icons.favorite,
//                 size: 35,
//                 color: isLiked ? Colors.red : Colors.white.withOpacity(0.7)),
//             onPressed: onLike,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Add a new section for creating new posts here
// class CreateNewPostSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(),

//         // UI elements for creating a new post
//       ],
//     );
//   }
// }
// //https://images.unsplash.com/photo-1570913149827-d2ac84ab3f9a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80