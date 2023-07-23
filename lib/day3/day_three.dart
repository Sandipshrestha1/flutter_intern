import 'package:flutter/material.dart';
import 'package:flutter_intern/lists.dart';

class Day3 extends StatefulWidget {
  const Day3({super.key});

  @override
  State<Day3> createState() => _Day3State();
}

class _Day3State extends State<Day3> {
  get index => null;
  bool _showAllItems = false;
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Day 3"),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                /*********************** */
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      height: 150,
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Image.asset(
                              items[index]['image'],
                              fit: BoxFit.cover,
                              height: 100,
                              width: 130,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Title: ${items[index]['title']}'),
                          Text('Date: ${items[index]['date']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
              width: double.infinity,
              //  child: Text("Hello"),
            ),
            Container(
              color: Colors.white70,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Single child scroll View "),
                  const Text("Flex"),
                  SizedBox(
                    height: _showAllItems ? 400 : 300,
                    child: ListView.builder(
                      itemCount: _showAllItems ? url.length : 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.all(3.0),
                          color: Colors.red[50],
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(110),
                              child: Image.network(
                                url[index],
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            title: Text('Picture $index'),
                            subtitle: Row(
                              children: [
                                const Icon(Icons.star),
                                Text('Description of the Image $index ')
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              child: const Text("Tap Here"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              _showAllItems = !_showAllItems;
                            },
                          );
                        },
                        child: Text(
                          _showAllItems ? "Show Less" : "Show More",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      for (int i = 0; i < (showMore ? itemList.length : 6); i++)
                        buildItem(itemList[i % itemList.length], Icons.start),
                    ],
                  ),
                ],
              ),
            ),
            if (itemList.length > 5)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            showMore = !showMore;
                          },
                        );
                      },
                      child: Icon(showMore
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
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

Widget buildItem(String text, IconData icon) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.alarm),
          const SizedBox(width: 10.0),
          Text(text),
        ],
      ),
    ),
  );
}
