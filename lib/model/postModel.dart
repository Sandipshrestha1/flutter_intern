import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phase1/screens/posts/first_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'userModel.dart';

class PostModel {
  String? userId;
  String? postid;
  String? postedataa;
  String? description;
  File? photo;
  List<String> postlikedby;

  PostModel({
    this.photo,
    required this.userId,
    required this.postid,
    required this.postedataa,
    required this.description,
    required this.postlikedby,
  });
  Map<String, dynamic> toJson() {
    String photoPath = photo != null ? photo!.path : "";
    return {
      'userid': userId,
      'postid': postid,
      'postedat': postedataa,
      'description': description,
      'postlikedby': postlikedby,
      'photo': photoPath,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    String photopath = json['photo'] ?? "";
    return PostModel(
        photo: File(photopath),
        userId: json['userId'],
        postid: json['postid'],
        postedataa: json['postedat'],
        description: json['description'],
        postlikedby: List<String>.from(json['postlikedby']));
  }
}

List<PostModel> postList = [];

class AddPost extends StatefulWidget {
  final userModel? loginUsers;
  const AddPost({Key? key, required this.loginUsers}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? postImage;
  List<PostModel> post = [];
  userModel? loginUsers;
  final ImagePicker picker = ImagePicker();

  Future takephoto() async {
    try {
      final pickedphoto = await picker.pickImage(source: ImageSource.gallery);
      if (pickedphoto == null) return;
      String photopath = pickedphoto.path;
      File? photo = File(photopath);
      setState(() {
        postImage = photo;
      });
    } catch (e) {
      //rethrow;
    }
  }

  // Map<String, dynamic> profileEmptyList = {};
  void postDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('profileData');
    //  print(jsonString);
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          post = jsonData.map((json) => PostModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          post.add(PostModel.fromJson(jsonData));
        }
      } catch (e) {
        rethrow;
      }
    }

    post.add(
      PostModel(
        photo: postImage,
        userId: widget.loginUsers!.userId,
        postid: const Uuid().v4(),
        description: descController.text,
        postedataa: DateTime.now().toString(),
        postlikedby: [],
      ),
    );

    List<Map<String, dynamic>> profileDataList =
        post.map((e) => e.toJson()).toList();
    String? profileData = jsonEncode(profileDataList);
    // print('profileData');
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('profileData', profileData);
  }

  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create your Post",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                postDetails();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstScreen()));
              });
            },
            child: const Text(
              "Tab To Post",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            takephoto();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add a photo')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Divider(
            //   thickness: 2,
            //   color: Color.fromARGB(255, 235, 130, 130),
            // ),
            const SizedBox(
              height: 15,
            ),
            const Text("Add your Post  Here :",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Decsription',
                labelStyle: TextStyle(
                  fontSize: 18,
                ),
                hintText: "What's on your Mind",
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 160, 210, 252)),
              child: Center(
                  child: postImage == null
                      ? const Text(
                          "Add Image",
                          style: TextStyle(fontSize: 20),
                        )
                      : Image(
                          height: 300,
                          width: double.infinity,
                          image: FileImage(postImage!),
                          fit: BoxFit.cover,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
