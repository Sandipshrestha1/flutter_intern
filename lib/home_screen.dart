import 'package:flutter/material.dart';
import '../list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAllItems = false;
  bool showMore = false;

  void toggleShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day 3"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: const [Icon(Icons.brightness_3_outlined)],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
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
          const SizedBox(height: 10),
          Flexible(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Vertical',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    const Text(
                      'Scroll float button for more Details',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    SizedBox(
                      height: _showAllItems ? 410 : 300,
                      child: ListView.builder(
                        itemCount: _showAllItems ? url.length : 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.all(3),
                            color: const Color.fromARGB(255, 222, 218, 218),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(110),
                                child: Image.network(
                                  url[index],
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              title: Text('Picture $index'),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.newspaper),
                                  Text('Description of the Image $index')
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
                                child: const Text("Click Me"),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAllItems = !_showAllItems;
                        });
                      },
                      child: Text(
                        _showAllItems ? "Show Less" : "Show More",
                      ),
                    ),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: [
                        for (int i = 0;
                            i < (showMore ? itemList.length : 5);
                            i++)
                          buildItem(itemList[i % itemList.length], Icons.star),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (itemList.length > 5)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Icon(showMore
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildItem(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}
