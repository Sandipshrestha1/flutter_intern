// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
// import 'package:phase1/model/userModel.dart';

import 'package:flutter/material.dart';
import 'package:phase1/Authentication/login_screen.dart';
import 'package:phase1/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userModel.dart';
import 'friends.dart';
import 'markets.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController
    super.dispose();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Socio App".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 10.0,
              color: Colors.blue,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomeSearch(),
                );
                // showSearch(
                //   context: context,
                //   delegate: CustomSearch(),
                // );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            labelStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: const TextStyle(fontSize: 18),
            indicatorWeight: 3.0,
            tabs: const [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(
                  text: 'Market',
                  icon: Icon(Icons.shopping_cart_checkout_sharp)),
              Tab(text: 'Friends', icon: Icon(Icons.family_restroom_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          // controller: controller,
          children: const [
            HomePage(),
            Markets(),
            Friends(),
          ],
        ),
      ),
    );
  }
}

/// Search Screen
class CustomeSearch extends SearchDelegate {
  // List<String> userList = [
  //   "Ram",
  //   "shyam",
  //   "Hari",
  //   "Gita",
  //   "Sita",
  //   "Rita",
  //   "unknown",
  // ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<userModel> matchQuery = usersData.where((user) {
      return user.fullName!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Friends()));
          },
          child: Card(
            color: Colors.green,
            child: ListTile(
              title: Text('${result.fullName}'),
              leading: ClipOval(
                child: result.profileimage.path != ""
                    ? Image(
                        height: 60,
                        width: 60,
                        image: FileImage(result.profileimage),
                        fit: BoxFit.cover,
                      )
                    : const Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('assets/person1.jpg'),
                        fit: BoxFit.cover,
                      ),
              ),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var user in userList) {
//       if (user.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(query);
//       }
//     }

//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(matchQuery[index]),
//         );
//       },
//     );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<userModel> matchQuery = usersData.where((user) {
      return user.fullName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    // for (var user in userList) {
    //   if (user.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(query);
    //   }
    //}

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('profileId', result.id.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Friends()));
          },
          child: Card(
            color: Colors.green,
            child: ListTile(
              title: Text('${result.fullName}'),
              leading: ClipOval(
                child: result.profileimage.path != ""
                    ? Image(
                        height: 60,
                        width: 60,
                        image: FileImage(result.profileimage),
                        fit: BoxFit.cover,
                      )
                    : const Image(
                        height: 60,
                        width: 60,
                        image: AssetImage('assets/person1.jpg'),
                        fit: BoxFit.cover,
                      ),
              ),
              subtitle: Text('${result.email}'),
            ),
          ),
        );
      },
    );
  }
}
