// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: MyListView(),
//         ),
//       ),
//     ),
//   ));
// }

import 'package:flutter/material.dart';

class MyListItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;

  MyListItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });
}

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  bool showAllItems = false;

  final List<MyListItem> items = [
    MyListItem(
      imageUrl: 'assets/images/git.png',
      title: 'Item 1',
      subtitle: 'Subtitle 1',
      description: 'Description 1',
      icon: Icons.star,
    ),
    MyListItem(
      imageUrl: 'assets/images/network.jpg',
      title: 'Item 2',
      subtitle: 'Subtitle 2',
      description: 'Description 2',
      icon: Icons.favorite,
    ),
    // Add more items as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day3'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Image.asset(
                          items[index].imageUrl,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        items[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        items[index].subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(items[index].icon),
                          const SizedBox(width: 5),
                          Text(items[index].description),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child: const Text('Button'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (items.length > 5)
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAllItems = !showAllItems;
                    });
                  },
                  child: Text(showAllItems ? 'Show Less' : 'Show More'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: MyListView(),
        ),
      ),
    ),
  ));
}
