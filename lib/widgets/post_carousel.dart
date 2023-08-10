// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class Post {
//   final String imageUrl;

//   Post({required this.imageUrl});
// }

// class PostCarousel extends StatelessWidget {
//   final PageController pageController;
//   final String title;
//   final List<Post> posts;

//   const PostCarousel({
//     required this.pageController,
//     required this.title,
//     required this.posts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 1.2,
//             ),
//           ),
//         ),
//         Container(
//           height: 400,
//           child: PageView.builder(
//             controller: pageController,
//             itemCount: posts.length,
//             itemBuilder: (BuildContext context, int index) {
//               Post post = posts[index];

//               return _buildPageView(post, index);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPageView(Post post, int index) {
//     return AnimatedBuilder(
//       animation: pageController,
//       builder: (BuildContext context, Widget? child) {
//         double value = 1;
//         if (pageController.position.haveDimensions) {
//           value = pageController.page! - index;
//           value = (1 - value.abs() * 0.25).clamp(0, 1);
//         }

//         return Center(
//           child: SizedBox(
//             height: Curves.easeInOut.transform(value) * 400,
//             child: child,
//           ),
//         );
//       },
//       child: Stack(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   offset: Offset(0, 2),
//                   blurRadius: 6.0,
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image(
//                 height: 400,
//                 width: 300,
//                 image: AssetImage(post.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 10,
//             right: 10,
//             child: Container(
//               height: 100,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white54,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(15),
//                   bottomRight: Radius.circular(15),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
