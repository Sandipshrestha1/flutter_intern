import 'package:flutter/material.dart';
import 'package:phase1/model/userModel.dart';
import 'package:phase1/screens/posts/first_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/login_screen.dart';
import 'friends/friends.dart';
import 'market/markets.dart';
import 'profile/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initLogindata();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> initLogindata() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  delegate: CustomSearch(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Home"),
                    Tab(text: "Market"),
                    Tab(text: "Friends")
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                FirstScreen(),
                MarketScreen(),
                Friends(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

// ... CustomSearch class remains unchanged ...

class CustomSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Friends()));
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

  @override
  Widget buildSuggestions(BuildContext context) {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Friends()));
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
