import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phase1/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<userModel> profileList = [];
  userModel? loginUsers;
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

  Future<void> setData() async {
    await getAllUserData();
    await getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Market'),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Image(
                      height: 60,
                      width: 60,
                      image: AssetImage('assets/person1.jpg')),
                  Column(children: [
                    const Text("Welcome Back "),
                    // Text(
                    //   loginUsers?.fullName ?? 'No Name',
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16,
                    //   ),
                    // ),

                    Text(
                      ' ${loginUsers?.fullName ?? "No Name"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ])
                ],
              ),
              Container(
                height: 120,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/network.jpg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
