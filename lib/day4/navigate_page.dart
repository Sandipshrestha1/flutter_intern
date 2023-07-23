import 'package:flutter/material.dart';

class NavigatePage extends StatelessWidget {
  const NavigatePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorListNav = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];

    return Scaffold(
        body: CustomScrollView(
      shrinkWrap: true,
      slivers: [
        const SliverAppBar(
          expandedHeight: 100,
          toolbarHeight: 80,
          pinned: true,
          title: Text("Navigated Page"),
          centerTitle: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 2,
            (context, index) {
              return Container(
                color: Colors.black26,
                height: 770,
                child: ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    //final listText = colorListNav[index];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: colorListNav[index % colorListNav.length],
                        ),
                        child: Center(child: Text("Hello World ${index + 1}")),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
