//import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phase1/Authentication/signup_Screen.dart';
import 'package:phase1/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../Authentication/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    userModel? loginUsers,
  });

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
    getAllUserData();
    getUserId();
  }

  Future<List<String>> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          profileList = decodedData.map((e) => userModel.fromJson(e)).toList();
        });
      } catch (e) {
        print("error occure ${e}");
      }
    } else {
      profileList = [];
    }
    return [];
  }

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        loginUsers =
            profileList.firstWhere((user) => user.id.toString() == userIdData);
        print("Image12: ${loginUsers!.coverimage}");
      } catch (e) {
        print(e);
      }
    } else {
      loginUsers;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [],
        title: const Text("Profile Page"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //buildTop(),

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
                        loginUsers!.coverimage,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const Text('No cover picture'),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                child: Image.file(
                  loginUsers!.coverimage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 140,
                left: MediaQuery.of(context).size.width / 2 - 80,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: loginUsers?.profileimage.path != ""
                        ? CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 50,
                            backgroundImage:
                                FileImage(loginUsers!.profileimage),
                          )
                        : const Text('No Image'),
                  ),
                ),
              )
            ],
          ),

          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  loginUsers?.fullName != ""
                      ? Text(' Name: ${loginUsers!.fullName}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))
                      : const Text('No Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  loginUsers?.email != ""
                      ? Text(
                          ' Email: ${loginUsers!.email}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : const Text('No Email'),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 20,
                    thickness: 4,
                    color: Colors.green,
                  ),
                  const Text('Phone Number',
                      //  textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text(
                      ' ${loginUsers!.mobileNumber}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Mobile Number"),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text('Gender',
                      //  textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      '${loginUsers!.gender}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Gender"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text('Date of Birth',
                      //  textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.cake),
                    ),
                    title: Text('${loginUsers!.dob}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("Date of Birth"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text('RelationShip',
                      //  textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.logo_dev),
                    ),
                    title: Text('${loginUsers!.maritialStatus}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text("Marritial Status"),
                  ),
                  const Divider(
                    height: 30,
                    thickness: 2,
                    color: Colors.red,
                  ),
                  const Text("Working Experience",
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                                    builder: (context) => const Screen1()));
                          },
                          child: const Text("Log out "))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
