import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phase1/Authentication/sign_up_screen.dart';
import 'package:phase1/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  final ImagePicker picker = ImagePicker();
  List<userModel> profileList = [];
  userModel? loginUsers;

  @override
  void initState() {
    super.initState();
    setData();
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
        print("error occurred: $e");
      }
    }
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        loginUsers =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
      } catch (e) {
        print("error occurred: $e");
      }
    }
  }

  Future<void> setData() async {
    await getAllUserData();
    await getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                child: loginUsers?.coverimage.path != ""
                    ? Image.file(
                        loginUsers?.coverimage ?? File(''),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const Text('No cover picture'),
              ),
              Positioned(
                top: 140,
                left: 20,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 3),
                  ),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: loginUsers?.profileimage.path != null &&
                            loginUsers!.profileimage.path.isNotEmpty
                        ? CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 50,
                            backgroundImage:
                                FileImage(loginUsers!.profileimage),
                          )
                        : const Text('No Image'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        // mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   // child: const Text("Add story"),
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.add),
                          //       const SizedBox(width: 5),
                          //       Text("Add story"),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: const Text("Edit"),
                          // ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Add story"),
                                    Icon(Icons.add),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.green,
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Edit"),
                                    Icon(Icons.edit),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 90),
                  Text(
                    loginUsers?.fullName ?? 'No Name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${loginUsers?.email ?? "No Email"}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 4,
                    color: Colors.green,
                  ),
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      ' ${loginUsers?.mobileNumber ?? "No Mobile Number"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Mobile Number"),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      ' ${loginUsers?.gender ?? "No Gender"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Gender"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text(
                    'Date of Birth',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.cake),
                    ),
                    title: Text(
                      ' ${loginUsers?.dob ?? "No Date of Birth"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Date of Birth"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text(
                    'RelationShip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.logo_dev),
                    ),
                    title: Text(
                      ' ${loginUsers?.maritialStatus ?? "No Marritial Status"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Marritial Status"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text(
                    "Working Experience",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.work),
                    ),
                    title: Text(
                      "Add work Experience",
                    ),
                    subtitle: Text("Worked Experience"),
                  ),
                  const Divider(
                    color: Colors.red,
                    height: 30,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Screen1(),
                            ),
                          );
                        },
                        child: const Text("Log out"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
