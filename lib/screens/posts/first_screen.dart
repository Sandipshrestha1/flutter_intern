import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phase1/model/postModel.dart';
import 'package:phase1/model/userModel.dart';
import 'package:phase1/screens/friends/friends_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../friends/friends.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<userModel> profileList = [];
  List<PostModel> userPostData = [];
  userModel? loginUsers;
  userModel? postIdDetails;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await getAllUserData();
    await getUserId();
    await getProfileData();
  }

  Future<List<String>> getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? profileString = pref.getString('profileData');
    print('========$profileString');
    if (profileString != null) {
      try {
        final decodeprofileData = json.decode(profileString) as List<dynamic>;
        setState(() {
          userPostData =
              decodeprofileData.map((e) => PostModel.fromJson(e)).toList();
        });
      } catch (e) {
        print("Error decoding user data: $e");
      }
    } else {
      userPostData = [];
    }
    return [];
  }

  Future<void> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          profileList = decodedData.map((e) => userModel.fromJson(e)).toList();
        });
      } catch (e) {
        print("error decoding user data: $e");
      }
    } else {
      profileList = [];
    }
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        loginUsers =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
        print(loginUsers?.fullName);
      } catch (e) {
        print("Error getting user by ID: $e");
      }
    } else {
      loginUsers = null;
      print("User not found");
    }
  }

  void toggleLike(String postId) {
    setState(() {
      final postIndex =
          userPostData.indexWhere((post) => post.postid == postId);
      if (postIndex != -1) {
        if (userPostData[postIndex].postlikedby.contains(loginUsers!.id)) {
          userPostData[postIndex].postlikedby.remove(loginUsers!.id);
        } else {
          userPostData[postIndex].postlikedby.add(loginUsers!.id.toString());
        }
      }
    });
  }

  void setData() async {
    await getAllUserData();
    await getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 1.9,
                color: Colors.green,
              ),
              const SizedBox(
                height: 1,
              ),
              // Row(
              //   children: [
              //     if (loginUsers?.fullName != null &&
              //         loginUsers!.fullName != "")
              //       Text(
              //         "Welcome \n Back: \n ${loginUsers!.fullName} ",
              //         style: const TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 30,
              //             color: Colors.blue),
              //       ),
              //     const Text('Hello'),
              //     const SizedBox(
              //       width: 80,
              //     ),
              //     Positioned(
              //       child: Container(
              //           height: 100,
              //           width: 100,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(color: Colors.green, width: 1.9),
              //           ),
              //           child: Container(
              //             height: 100,
              //             width: 100,
              //             decoration: const BoxDecoration(
              //                 shape: BoxShape.circle, color: Colors.blue),
              //             child: loginUsers?.profileimage != null &&
              //                     // ignore: unrelated_type_equality_checks
              //                     loginUsers!.profileimage != ""
              //                 ? CircleAvatar(
              //                     backgroundColor: Colors.yellow,
              //                     radius: 30,
              //                     backgroundImage:
              //                         FileImage(loginUsers!.profileimage),
              //                   )
              //                 : const Text('No Image'),
              //           )),
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  // CircleAvatar(
                  //   radius: 80,
                  //   backgroundImage: FileImage(loginUsers!.coverimage),

                  //   //     NetworkImage(
                  //   //   "https://www.shutterstock.com/image-illustration/peace-symbol-made-common-metal-600w-2161222931.jpg",
                  //   // ),
                  // ),

                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: loginUsers?.profileimage.path != null &&
                            loginUsers!.profileimage.path.isNotEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 60,
                            backgroundImage:
                                FileImage(loginUsers!.profileimage),
                          )
                        : const Icon(
                            Icons.account_circle,
                            size: 60,
                            color: Colors.black,
                          ),

                    //: const Text(''),
                  ),

                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPost(
                              loginUsers: loginUsers,
                            ),
                          ),
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
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => AddPost(
              //           loginUsers: loginUsers,
              //         ),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     height: 45,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: const Color.fromARGB(255, 243, 143, 143)),
              //     child: const Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: Text(
              //         "Add to your Post",
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ),
              //   ),
              // ),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userPostData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = userPostData[index];

                    postIdDetails = profileList
                        .firstWhere((user) => user.userId == data.userId);

                    //postIdDetails =
                    //     profileList.firstWhere((user) => user.userId.userId);
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: const Color.fromARGB(255, 160, 210, 252),
                        color: const Color.fromARGB(255, 160, 210, 252),
                        elevation: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('profileData',
                                            data.userId.toString());
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FriendsDetails()));
                                      },
                                      child: ClipOval(
                                          child: loginUsers
                                                          ?.profileimage.path !=
                                                      null &&
                                                  loginUsers!.profileimage != ""
                                              ? Image(
                                                  height: 40,
                                                  width: 40,
                                                  image: FileImage(
                                                      loginUsers!.profileimage),
                                                  fit: BoxFit.cover,
                                                )
                                              : const Text('No Image')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${postIdDetails!.fullName}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('${data.postedataa}',
                                          style: const TextStyle(fontSize: 14))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (data.description != "")
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${data.description}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              )
                            else
                              const Text("hello"),
                            Container(
                              height: 350,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: data.photo != null
                                    ? DecorationImage(
                                        image: FileImage(data.photo!),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      toggleLike(data.postid.toString());
                                    },
                                    icon: data.postlikedby
                                            .contains(loginUsers!.id)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.brown,
                                          )
                                        : const Icon(Icons.favorite_border)),
                                Text('${data.postlikedby.length}'),
                                const SizedBox(width: 5),
                                const Text('Like')
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
