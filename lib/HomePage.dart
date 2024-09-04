import 'package:flutter/material.dart';
import 'package:ything_radio/About.dart';
import 'package:ything_radio/EasyTab.dart';
import 'package:ything_radio/Links.dart';
import 'package:ything_radio/Listen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  final List<EasyTab> easytabs = const [
    EasyTab(title: "Listen", icon: Icons.play_arrow, child: Listen()),
    EasyTab(title: "About", icon: Icons.help, child: About()),
    EasyTab(title: "Links", icon: Icons.language, child: Links()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: easytabs.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.inversePrimary,
          child: TabBar(
              tabs: easytabs
                  .map((tab_item) =>
                      Tab(text: tab_item.title, icon: Icon(tab_item.icon)))
                  .toList()),
        ),
        body: TabBarView(
            children: easytabs.map((tab_item) => tab_item.child).toList()),
      ),
    );
  }
}
