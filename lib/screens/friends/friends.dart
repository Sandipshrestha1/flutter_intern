//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users[index];
//         return Card(
//           child: ListTile(
//             leading: CircleAvatar(
//               radius: 28,
//               backgroundImage: AssetImage(user.urlimg),
//             ),
//             title: Text(user.username),
//             subtitle: Text(user.email),
//           ),
//         );
//       },
//     );
//   }

import 'package:flutter/material.dart';

class Test {
  final String username;
  final String email;
  final String urlimg;

  const Test({
    required this.username,
    required this.email,
    required this.urlimg,
  });

  static Test fromJson(json) => Test(
      username: json['username'], email: json['email'], urlimg: json['urlimg']);
}

class Friends extends StatefulWidget {
  Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();

  static List<Test> getUsers() {
    const data = [
      {
        "username": "Sandy",
        "email": "sandy@gmail.com",
        "password": "Sandy@123",
        "urlimg": "assets/person1.jpg"
      },
      {
        "username": "Samir",
        "email": "samir@gmail.com",
        "password": "Samir@123",
        "urlimg": "assets/person1.jpg"
      },
    ];
    return data.map<Test>((json) => Test.fromJson(json)).toList();
  }
}

class _FriendsState extends State<Friends> {
  List<Test> users = Friends.getUsers(); // Access the list of users

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildUsers(users),
      ),
    );
  }

  Widget buildUsers(List<Test> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(user.urlimg),
            ),
            title: Text(user.username),
            subtitle: Text(user.email),
          ),
        );
      },
    );
  }
}
