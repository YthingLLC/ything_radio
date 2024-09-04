import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: TabBar(tabs: [
              Placeholder(),
              Placeholder(),
              Placeholder(),
            ]),
          ),
        ));
  }
}
