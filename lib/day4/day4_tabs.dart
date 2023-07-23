import 'package:flutter/material.dart';

class Day4 extends StatefulWidget {
  const Day4({super.key});

  @override
  State<Day4> createState() => _Day4State();
}

class _Day4State extends State<Day4> {
  bool _showAllItems = false;
  //
  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.green,
      Colors.red,
      Colors.purple,
    ];

    List<String> titleText = ['Hello', ' Hi', 'Bye', 'Good', ' Hi'];
    List<Map<String, dynamic>> lists = [
      {
        'title': 'Hello',
        'imageUrl':
            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      },
      {'title': 'hi', 'imageUrl': 'https://picsum.photos/250?image=9'},
      {
        'title': 'Hello',
        'imageUrl':
            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      },
      {'title': 'hi', 'imageUrl': 'https://picsum.photos/250?image=9'},
      {
        'title': 'Hello',
        'imageUrl':
            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      },
      {'title': 'hi', 'imageUrl': 'https://picsum.photos/250?image=9'},
      {
        'title': "Network",
        'imageUrl': '      data:image/png',
      },
      {
        'title': 'Hello',
        'imageUrl':
            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        // color: Colors.deepOrange,
        decoration: BoxDecoration(
            color: Colors.amber.shade300,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                offset: Offset(5, 10),
                spreadRadius: 0.1,
                blurStyle: BlurStyle.normal,
              )
            ]),
        child: Column(
          children: [
            const Text(
              "Title: Container Title",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Text(
              "SubTitle: This is sub Title",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" Date: 2023-jan-15"),
                Text("10: 00 Am "),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                //color: Colors.green,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _showAllItems ? lists.length : 3,
                  itemBuilder: (BuildContext context, index) {
                    final listss = lists[index];
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: colorList[index % colorList.length],
                      ),
                      child: Column(
                        children: [
                          Text(listss['title']),
                          SizedBox(
                            height: 150,
                            child: Image.network(
                              listss['imageUrl'],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showAllItems = !_showAllItems;
                });
              },
              child: Text(
                _showAllItems ? "show less" : "show More",
              ),
            ),
            const Divider(
              thickness: 10,
              color: Colors.green,
            ),
            Container(
              height: 180,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 9,
                children: [
                  for (int i = 0; i < 28; i++)
                    Container(
                      color: colorList[i % colorList.length],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
