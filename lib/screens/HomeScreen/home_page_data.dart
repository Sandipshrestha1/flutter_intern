// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:phase1/Authentication/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:phase1/model/userModel.dart';
// import '../dummy.dart';
// import '../friends/friends.dart';
// import '../posts/first_screen.dart';
// import '../profile/profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   late SharedPreferences logindata;
//   late String username;

//   @override
//   void initState() {
//     super.initState();
//     initLogindata();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   Future<void> initLogindata() async {
//     logindata = await SharedPreferences.getInstance();
//     setState(() {
//       username = logindata.getString('username')!;
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           centerTitle: true,
//           title: Text(
//             "Socio App".toUpperCase(),
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               letterSpacing: 10.0,
//               color: Colors.blue,
//             ),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const Profile(),
//                   ),
//                 );
//               },
//             ),
//             IconButton(
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: CustomSearch(),
//                 );
//               },
//               icon: const Icon(Icons.search),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(25.0),
//                 ),
//                 child: TabBar(
//                   indicator: BoxDecoration(
//                     color: Colors.green[400],
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.black,
//                   tabs: [
//                     Tab(text: "Home"),
//                     Tab(text: "Market"),
//                     Tab(text: "Friends")
//                   ],
//                 ),
//               ),
//               Expanded(
//                   child: TabBarView(children: [
//                 FirstScreen(),
//                 dummy(),
//                 Center(
//                   child: Text("Friends Page"),
//                 ),
//               ]))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomSearch extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<userModel> matchQuery = usersData.where((user) {
//       return user.fullName!.toLowerCase().contains(query.toLowerCase());
//     }).toList();

//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return InkWell(
//           onTap: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             prefs.setString('profileId', result.id.toString());
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const Friends()));
//           },
//           child: Card(
//             color: Colors.green,
//             child: ListTile(
//               title: Text('${result.fullName}'),
//               leading: ClipOval(
//                 child: result.profileimage.path != ""
//                     ? Image(
//                         height: 60,
//                         width: 60,
//                         image: FileImage(result.profileimage),
//                         fit: BoxFit.cover,
//                       )
//                     : const Image(
//                         height: 60,
//                         width: 60,
//                         image: AssetImage('assets/person1.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//               ),
//               subtitle: Text('${result.email}'),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<userModel> matchQuery = usersData.where((user) {
//       return user.fullName!.toLowerCase().contains(query.toLowerCase());
//     }).toList();

//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return InkWell(
//           onTap: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             prefs.setString('profileId', result.id.toString());
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const Friends()));
//           },
//           child: Card(
//             color: Colors.green,
//             child: ListTile(
//               title: Text('${result.fullName}'),
//               leading: ClipOval(
//                 child: result.profileimage.path != ""
//                     ? Image(
//                         height: 60,
//                         width: 60,
//                         image: FileImage(result.profileimage),
//                         fit: BoxFit.cover,
//                       )
//                     : const Image(
//                         height: 60,
//                         width: 60,
//                         image: AssetImage('assets/person1.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//               ),
//               subtitle: Text('${result.email}'),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phase1/model/postModel.dart';
import 'package:phase1/model/userModel.dart';
import 'package:phase1/screens/friends/friends.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    // print('========$profileString');
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
    String? userIdData = prefs.getString('userid');

    if (userIdData != null) {
      try {
        loginUsers =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
        // print(loginUsers?.fullname);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const Text(
      //     "Homepage",
      //     style: TextStyle(color: Colors.blue, fontSize: 25),
      //   ),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Divider(
              //   thickness: 2,
              //   color: Color.fromARGB(255, 235, 130, 130),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // if (loginUsers?.fullName != null &&
                  //     loginUsers!.fullName != "")
                  //   Text(
                  //     "Welcome \n Back: \n ${loginUsers!.fullName} ",
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 30,
                  //         color: Colors.blue),
                  //   )
                  // else
                  //   const Text('Hello'),
                  // const SizedBox(
                  //   width: 80,
                  // ),
                  Positioned(
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                        ),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: loginUsers?.profileimage != null &&
                                  // ignore: unrelated_type_equality_checks
                                  loginUsers!.profileimage != ""
                              ? CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 30,
                                  backgroundImage:
                                      FileImage(loginUsers!.profileimage),
                                )
                              : const Text('No Image'),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPost(
                        loginUsers: loginUsers,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 243, 143, 143)),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Add to your Post",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userPostData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = userPostData[index];
                    postIdDetails = profileList
                        .firstWhere((user) => user.id == data.userId);
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
                                                    Friends()));
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
                              const Text(""),
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
