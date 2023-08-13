// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:phase1/model/postModel.dart';
// // import 'package:phase1/model/userModel.dart';
// // import 'package:phase1/widgets/login_signup.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:uuid/uuid.dart';
// // import 'home_page.dart';

// // class AddPost extends StatefulWidget {
// //     final userModel? loginUsers;
// //   const AddPost({super.key, required this.loginUsers});
// //   @override
// //   State<AddPost> createState() => _AddPostState();
// // }

// // class _AddPostState extends State<AddPost> {
// //   File? postImage;
// //   final ImagePicker picker = ImagePicker();
// //   Future takePhoto() async {
// //     try {
// //       final pickedProfile = await picker.pickImage(source:
// // ImageSource.gallery);

// //       if (pickedProfile == null) return;

// //       String imagePath = pickedProfile.path;
// //       File? img = File(imagePath);
// //       setState(() {

// //         postImage = img;

// //       });

// //     } on PlatformException {

// //     }
// //   }
// //   Map<String, dynamic> profileEmptyList = {};

// //   void postDetails() async {

// //     SharedPreferences sharedPreferences = await

// // SharedPreferences.getInstance();
// //     String? jsonString = sharedPreferences.getString('profileData');

// //     if (jsonString != null) {

// //       try {

// //         final jsonData = jsonDecode(jsonString);
// //         if (jsonData is List<dynamic>) {
// //           postList = jsonData.map((json) =>

// // PostModel.fromJson(json)).toList();
// //         } else if (jsonData is Map<String, dynamic>) {
// //           postList.add(PostModel.fromJson(jsonData));
// //         }

// //       } catch (e) {

// //   rethrow;
// //       }
// //     }

// //  postList.add(PostModel(
// //         postId: const Uuid().v4(),
// //         userId:'', //widget.loginUsers!.id,
// //           createdAt: DateTime.now().toString(),
// //         description: descController.text,
// //         image: postImage!,
// //         postLikedBy: []));
// //     List<Map<String, dynamic>> profileDataList =
// //         postList.map((e) => e.toJson()).toList();
// //     String profileData = jsonEncode(profileDataList);
// //     sharedPreferences.setString('profileData', profileData);
// //   }
// //     TextEditingController descController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       appBar: AppBar(
// //         backgroundColor: Colors.lightGreen,
// //         title: const Text(
// //           'Create post',
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.brown,
// //           ),
// //         ),
// //         actions: [
// //           ElevatedButton(
// //               onPressed: setState(() {
// //                 postDetails();
// //                 Navigator.pushReplacement(context,
// //                     MaterialPageRoute(builder: (context) => const HomePage()));
// //               }), child: const Text("Add Post "),
// //   },

// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton.extended(
// //         onPressed: () {
// //                     takePhoto();
// //                       },
// //         icon: const Icon(Icons.add),
// //         label: const Text('Add Image'),
// //       ),

// //       body: Padding(
// //         padding: const EdgeInsets.all(10.0),

// // child: Column(

// //           crossAxisAlignment: CrossAxisAlignment.start,

// //           children: [
// //             const Text('Description',

// //                 style: TextStyle(

// //                     fontSize: 20,

// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black,)),

// //             const SizedBox(height: 10),

// //             formtext(
// //                 labeltext: 'Description',
// //                 hinttext: 'Write some description',

// //       ),
// //             const SizedBox(height: 10),

// //             Container(

// //               height: 300,              width: double.infinity,
// // decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(25),
// //                 //color: textfieldGrey,

// //               ),
// //               child: Center(
// //                   child: postImage == null

// //                       ? const Text(
// //                           'Add Image',

// //                           style: TextStyle(fontSize: 25),

// //                         )

// //                       : Image(

// //                           height: 300,
// //                           width: double.infinity,
// //                           image: FileImage(postImage!),

// //                                                     fit: BoxFit.cover,

// //   )),
// //   )
// //    ],
// // ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:phase1/Authentication/login_screen.dart';
// import 'package:phase1/model/postModel.dart';
// import 'package:phase1/model/userModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class AddPost extends StatefulWidget {
//   final userModel? loginUsers;

//   const AddPost({Key? key, required this.loginUsers}) : super(key: key);

//   @override
//   State<AddPost> createState() => _AddPostState();
// }

// class _AddPostState extends State<AddPost> {
//   File? postImage;
//   final ImagePicker picker = ImagePicker();
//   List<PostModel> postList = []; // Declare postList

//   Future<void> takePhoto() async {
//     try {
//       final pickedProfile = await picker.pickImage(source: ImageSource.gallery);

//       if (pickedProfile == null) return;

//       String imagePath = pickedProfile.path;
//       File? img = File(imagePath);
//       setState(() {
//         postImage = img;
//       });
//     } on PlatformException {
//       // Handle platform exception
//     }
//   }

//   userModel? loginUsers;
//   Future<void> getUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userIdData = prefs.getString('userID');

//     if (userIdData != null) {
//       try {
//         // final decodedData = json.decode(userIdData) as List<dynamic>;
//         loginUsers =
//             usersData.firstWhere((user) => user.id.toString() == userIdData);
//         // print("DATA::: ${loginUsers?.profileimage}");

//         // print("Image12: ${loginUsers!.profileimage}");
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   void postDetails() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? jsonString = sharedPreferences.getString('profileData');

//     if (jsonString != null) {
//       try {
//         final jsonData = jsonDecode(jsonString);
//         if (jsonData is List<dynamic>) {
//           postList = jsonData.map((json) => PostModel.fromJson(json)).toList();
//         } else if (jsonData is Map<String, dynamic>) {
//           postList.add(PostModel.fromJson(jsonData));
//         }
//       } catch (e) {
//         // Handle JSON parsing error
//         rethrow;
//       }
//     }

//     postList.add(PostModel(
//       postid: const Uuid().v4(),
//       userid: loginUsers!.id.toString(),
//       createdAt: DateTime.now().toString(),
//       description: descController.text,
//       image: postImage!,
//       postLikedBy: [],
//     ));

//     List<Map<String, dynamic>> profileDataList =
//         postList.map((e) => e.toJson()).toList();
//     String profileData = jsonEncode(profileDataList);
//     sharedPreferences.setString('profileData', profileData);
//   }

//   TextEditingController descController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.lightGreen,
//         title: const Text(
//           'Create post',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.brown,
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 postDetails();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FirstScreen(usersData: usersData),
//                   ),
//                 );
//               });
//             },
//             child: const Text("Add Post "),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           takePhoto();
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add Image'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Description',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: descController,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 hintText: 'Write some description',
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               height: 300,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 //color: textfieldGrey,
//               ),
//               child: Center(
//                 child: postImage == null
//                     ? const Text(
//                         'Add Image',
//                         style: TextStyle(fontSize: 25),
//                       )
//                     : Image(
//                         height: 300,
//                         width: double.infinity,
//                         image: FileImage(postImage!),
//                         fit: BoxFit.cover,
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
