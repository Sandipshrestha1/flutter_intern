import 'package:flutter/material.dart';
import 'package:flutter_intern/day3/day_three.dart';
import 'package:flutter_intern/day4/day4_tabs.dart';
import 'package:flutter_intern/day_1/Day_One.dart';

import 'navigate_page.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  // TabController _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Assignment 4 "),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigatePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.hourglass_empty_outlined))
          ],
        ),
        body: const Column(
          children: [
            TabBar(
              // controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.transfer_within_a_station_outlined,
                  ),
                  text: ("Day2"),
                ),
                Tab(
                  icon: Icon(Icons.threed_rotation_outlined),
                  text: ("Day3"),
                ),
                Tab(
                  icon: Icon(Icons.forum_rounded),
                  text: ("Day4"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Day2(),
                  Day3(),
                  Day4(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
